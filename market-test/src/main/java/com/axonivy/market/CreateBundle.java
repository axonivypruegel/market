package com.axonivy.market;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.stream.Collectors;

import org.apache.commons.io.FileUtils;
import org.json.JSONObject;

public class CreateBundle
{
  public static void main(String[] args) throws IOException
  {
    var targetDir = new File("target/market/");
    FileUtils.deleteDirectory(targetDir);
    for (var metaJson : metaJsons())
    {
      var srcDir = metaJson.getParent().toFile();
      var json = toJsonObject(metaJson);
      var id = json.getString("id");
      var destDir = new File(targetDir, id);  
      System.out.println(srcDir);
      FileUtils.copyDirectory(srcDir, destDir);
    }
  }
  
  private static JSONObject toJsonObject(Path path)
  {
    try
    {
      var actual = Files.readString(path);
      return new JSONObject(actual);
    }
    catch (IOException ex)
    {
      throw new RuntimeException(ex);
    }
  }
  
  private static List<Path> metaJsons()
  {
    try
    {
      var marketRoot = marketRoot();
      return Files.walk(marketRoot, Integer.MAX_VALUE)
              .filter(path -> path.endsWith("meta.json"))
              .filter(path -> !path.equals(marketRoot))
              .collect(Collectors.toList());
    }
    catch (IOException ex)
    {
      throw new RuntimeException(ex);
    }
  }

  private static Path marketRoot()
  {
    return Paths.get("..").resolve("market");
  }
}
