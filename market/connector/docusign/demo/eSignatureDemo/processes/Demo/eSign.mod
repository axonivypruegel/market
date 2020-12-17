[Ivy]
17651A0FB6AFB366 9.2.0 #module
>Proto >Proto Collection #zClass
st0 eSign Big #zClass
st0 B #cInfo
st0 #process
st0 @TextInP .type .type #zField
st0 @TextInP .processKind .processKind #zField
st0 @TextInP .xml .xml #zField
st0 @TextInP .responsibility .responsibility #zField
st0 @StartRequest f0 '' #zField
st0 @EndTask f1 '' #zField
st0 @ProcessException f5 '' #zField
st0 @StartRequest f2 '' #zField
st0 @RestClientCall f6 '' #zField
st0 @PushWFArc f9 '' #zField
st0 @PushWFArc f8 '' #zField
st0 @RestClientCall f10 '' #zField
st0 @PushWFArc f3 '' #zField
st0 @PushWFArc f4 '' #zField
st0 @EndRequest f7 '' #zField
st0 @StartRequest f11 '' #zField
st0 @PushWFArc f12 '' #zField
>Proto st0 st0 eSign #zField
st0 f0 outLink start.ivp #txt
st0 f0 inParamDecl '<> param;' #txt
st0 f0 requestEnabled true #txt
st0 f0 triggerEnabled false #txt
st0 f0 callSignature start() #txt
st0 f0 startName '1. Initiate a digital document signing workflow' #txt
st0 f0 caseData businessCase.attach=true #txt
st0 f0 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>start.ivp</name>
    </language>
</elementInfo>
' #txt
st0 f0 @C|.responsibility Everybody #txt
st0 f0 81 49 30 30 -25 17 #rect
st0 f0 @|StartRequestIcon #fIcon
st0 f1 385 145 30 30 0 15 #rect
st0 f1 @|EndIcon #fIcon
st0 f5 actionTable 'out=in;
' #txt
st0 f5 actionCode 'import ch.ivyteam.ivy.bpm.error.BpmError;

import ch.ivyteam.ivy.request.IHttpResponse;

if (error.getAttributeNames().contains("authUri"))
{
  java.net.URI uri = error.getAttribute("authUri") as java.net.URI;
  ivy.log.info("redirecting to docuSign auth: "+uri.toASCIIString());
  IHttpResponse.current().sendRedirect(uri.toASCIIString());
}
else
{
  BpmError.create(error).withErrorCode("docusign:error").throwError();
}' #txt
st0 f5 errorCode ivy:error:rest:client #txt
st0 f5 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>auth:error</name>
    </language>
</elementInfo>
' #txt
st0 f5 81 145 30 30 -25 19 #rect
st0 f5 @|ExceptionIcon #fIcon
st0 f2 outLink authenticated.ivp #txt
st0 f2 inParamDecl '<String code> param;' #txt
st0 f2 actionCode 'ivy.log.info("got authCode: "+param.code);
ivy.session.setAttribute(net.docusign.auth.OAuth2Feature.SESSION_TOKEN, param.code);' #txt
st0 f2 requestEnabled true #txt
st0 f2 triggerEnabled false #txt
st0 f2 callSignature authenticated(String) #txt
st0 f2 caseData businessCase.attach=true #txt
st0 f2 showInStartList 0 #txt
st0 f2 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>authenticated.ivp</name>
    </language>
</elementInfo>
' #txt
st0 f2 @C|.responsibility Everybody #txt
st0 f2 161 145 30 30 -33 19 #rect
st0 f2 @|StartRequestIcon #fIcon
st0 f6 clientId 17e5dc27-5699-4717-ae6c-e2c8f1e2a30f #txt
st0 f6 path /v2.1/accounts/{accountId}/envelopes #txt
st0 f6 queryParams 'ac_status=;
block=;
cdse_mode=;
continuation_token=;
count=;
custom_field=;
email=;
envelope_ids=;
exclude=;
folder_ids=;
folder_types=;
from_date="2017-05-02T04:11Z";
from_to_status=;
include=;
include_purge_information=;
intersecting_folder_ids=;
last_queried_date=;
order=;
order_by=;
powerformids=;
query_budget=;
requester_date_format=;
search_text=;
start_position=;
status=;
to_date=;
transaction_ids=;
user_filter=;
user_id=;
user_name=;
' #txt
st0 f6 templateParams 'accountId="placeholder";
' #txt
st0 f6 resultType com.docusign.esign.model.EnvelopesInformation #txt
st0 f6 responseMapping 'out.envelopes=result.envelopes;
' #txt
st0 f6 clientErrorCode ivy:error:rest:client #txt
st0 f6 statusErrorCode ivy:error:rest:client #txt
st0 f6 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>read envelopes</name>
    </language>
</elementInfo>
' #txt
st0 f6 168 42 112 44 -48 -7 #rect
st0 f6 @|RestClientCallIcon #fIcon
st0 f9 111 64 168 64 #arcP
st0 f8 182 146 224 86 #arcP
st0 f10 clientId 17e5dc27-5699-4717-ae6c-e2c8f1e2a30f #txt
st0 f10 path /v2.1/accounts/{accountId}/envelopes #txt
st0 f10 queryParams 'cdse_mode=;
change_routing_order=;
completed_documents_only=;
merge_roles_on_draft=;
' #txt
st0 f10 templateParams 'accountId="placeholder";
' #txt
st0 f10 method POST #txt
st0 f10 bodyInputType ENTITY #txt
st0 f10 bodyObjectType com.docusign.esign.model.EnvelopeDefinition #txt
st0 f10 bodyObjectMapping 'param.documents=[ net.docusign.DocUtils.ofLocalFile("webContent/sampleDoc.rtf") ];
param.emailSubject="Connecting Axon.ivy with DocuSign";
param.recipients.signers=[ net.docusign.SignUtils.myself(ivy.session) ];
param.status="sent";
' #txt
st0 f10 resultType com.docusign.esign.model.EnvelopeSummary #txt
st0 f10 clientErrorCode ivy:error:rest:client #txt
st0 f10 statusErrorCode ivy:error:rest:client #txt
st0 f10 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>create envelope</name>
    </language>
</elementInfo>
' #txt
st0 f10 344 42 112 44 -51 -7 #rect
st0 f10 @|RestClientCallIcon #fIcon
st0 f3 400 86 400 145 #arcP
st0 f4 280 64 344 64 #arcP
st0 f7 template "/redirect.ivc" #txt
st0 f7 209 273 30 30 0 15 #rect
st0 f7 @|EndRequestIcon #fIcon
st0 f11 outLink visitSigningApp.ivp #txt
st0 f11 inParamDecl '<> param;' #txt
st0 f11 requestEnabled true #txt
st0 f11 triggerEnabled false #txt
st0 f11 callSignature visitSigningApp() #txt
st0 f11 startName '2. digital document inbox overview' #txt
st0 f11 caseData businessCase.attach=true #txt
st0 f11 @C|.xml '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<elementInfo>
    <language>
        <name>visitSigningApp.ivp</name>
    </language>
</elementInfo>
' #txt
st0 f11 @C|.responsibility Everybody #txt
st0 f11 81 273 30 30 -45 18 #rect
st0 f11 @|StartRequestIcon #fIcon
st0 f12 111 288 209 288 #arcP
>Proto st0 .type net.docusign.esignature.demo.Data #txt
>Proto st0 .processKind NORMAL #txt
>Proto st0 0 0 32 24 18 0 #rect
>Proto st0 @|BIcon #fIcon
st0 f0 mainOut f9 tail #connect
st0 f9 head f6 mainIn #connect
st0 f2 mainOut f8 tail #connect
st0 f8 head f6 mainIn #connect
st0 f10 mainOut f3 tail #connect
st0 f3 head f1 mainIn #connect
st0 f6 mainOut f4 tail #connect
st0 f4 head f10 mainIn #connect
st0 f11 mainOut f12 tail #connect
st0 f12 head f7 mainIn #connect