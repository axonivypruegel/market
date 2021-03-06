package net.docusign.auth;

import java.io.IOException;
import java.net.URI;

import javax.ws.rs.client.ClientRequestContext;
import javax.ws.rs.core.UriBuilder;
import javax.ws.rs.ext.Provider;

import org.apache.commons.lang3.StringUtils;

import com.fasterxml.jackson.databind.JsonNode;

import ch.ivyteam.ivy.environment.Ivy;
import ch.ivyteam.ivy.rest.client.oauth2.uri.OAuth2UriProperty;
import ch.ivyteam.ivy.security.ISession;

/**
 * Customizes the baseURI according the the 'userInfo'. 
 * 
 * <p>See: <b>Step 3. Get your user's base URI</b>
 * https://developers.docusign.com/platform/auth/authcode/authcode-get-token/</p>
 * 
 * @since 9.2
 */
@Provider 
public class UserUriFilter implements javax.ws.rs.client.ClientRequestFilter
{
  private static final String USER_INFO = "docusign.userInfo";
  
  private final ISession session;
  private final OAuth2UriProperty uriFactory;
  
  public UserUriFilter(ISession session, OAuth2UriProperty uriFactory)
  {
    this.session = session;
    this.uriFactory = uriFactory;
  }
  
  @Override
  public void filter(ClientRequestContext context) throws IOException
  {
    if (uriFactory.isAuthRequest(context.getUri()))
    { // do not intercept token request: avoid stackOverFlow!
      return;
    }
    
    JsonNode userInfo = readUserInfo(session);
    if (userInfo == null)
    {
      userInfo = context.getClient()
        .target(uriFactory.getUri("userinfo"))
        .request()
        .headers(context.getHeaders()) // copy bearer token
        .get().readEntity(JsonNode.class);
      session.setAttribute(USER_INFO, userInfo);
    }
    
    URI userUri = routeToUserUri(context.getUri(), userInfo.get("accounts"));
    context.setUri(userUri);
  }

  public static JsonNode readUserInfo(ISession s)
  {
    return (JsonNode)s.getAttribute(USER_INFO);
  }

  private static URI routeToUserUri(URI uri, JsonNode accounts)
  {
    Ivy.log().debug("patching URI: "+uri);
    String resource = StringUtils.substringAfter(uri.getPath(), "placeholder/");
    String rawQuery = uri.getRawQuery();
    
    JsonNode first = accounts.get(0);
    URI baseUri = URI.create(first.get("base_uri").asText());
    URI userUri = UriBuilder.fromUri(baseUri).path("/restapi/v2.1/accounts/{myId}")
      .resolveTemplate("myId", first.get("account_id").asText())
      .path(resource)
      .replaceQuery(rawQuery)
      .build();
    Ivy.log().debug("patched user URI: "+userUri);
    
    return userUri;
  }
}