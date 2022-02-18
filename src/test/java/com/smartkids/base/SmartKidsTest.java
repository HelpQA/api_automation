package com.smartkids.base;

import static org.junit.Assert.assertTrue;
import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.ArrayList;
import java.util.Date;
import java.util.Collection;
import java.lang.Runtime;
import java.io.*;
import java.lang.management.*;
import org.apache.commons.io.FileUtils;
import org.junit.BeforeClass;
import org.junit.AfterClass;
import org.junit.Test;
import org.yaml.snakeyaml.Yaml;

import com.intuit.karate.KarateOptions;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import net.minidev.json.JSONValue;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

@KarateOptions(features = {"classpath:com/smartkids"},
	tags = {"@pgservices"})

public class SmartKidsTest {
	static String karateOutputPath = "target/surefire-reports";
	@BeforeClass
	public static void before() {
		
	}

	@Test
	public void testParallel() {
		
		Results stats = Runner.parallel(getClass(), 1, karateOutputPath);
		
		assertTrue("there are scenario failures", stats.getFailCount() == 0);
	}

	@AfterClass
	public static void after(){
		generateReport(karateOutputPath);
	}

	private static void generateReport(String karateOutputPath) {

		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
		Date date = new Date();
		String currentDate = dateFormat.format(date);

		Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] { "json" }, true);
		List<String> jsonPaths = new ArrayList(jsonFiles.size());
		jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
		
		// To Store reports in other location in system
		Configuration config = new Configuration(new File("target/" + currentDate), "SmartKids Test Automation Results");

		ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
		reportBuilder.generateReports();
	}

	public static String converToString(String conValue) {
		return conValue.replaceAll("\"", "");
	}
	
	public static String getYamlProperties(String yamlString) {
	    Yaml yaml= new Yaml();
	    Object obj = yaml.load(yamlString);

	    return JSONValue.toJSONString(obj);
	}

	public static void writeToFile(String filePath,String text) 
  		throws IOException {
			String fileContent = text;
			System.out.println(System.getProperty("user.dir")+filePath);
    		File file = new File(System.getProperty("user.dir")+filePath);
			FileOutputStream fos = new FileOutputStream(file, false);
			fos.write(fileContent.getBytes());
			fos.close();
		}
}