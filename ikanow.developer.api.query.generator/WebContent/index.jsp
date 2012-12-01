<!--
Copyright 2012 The Infinit.e Open Source Project

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>IKANOW API - Query Generator<</title>
	
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
	
	<link rel="shortcut icon" href="image/favicon.ico" />
	<link rel="stylesheet" type="text/css" href="lib/codemirror.css" />
	
    <!-- Le styles -->
    <link href="lib/bootstrap/css/bootstrap.css" rel="stylesheet">
    <style type="text/css">
      body {
        padding-top: 25px;
        padding-bottom: 25px;
        background-color: #ADDEEF;
      }

      .form-signin {
        padding: 15px 15px 15px;
        margin: 0 auto 20px;
        background-color: #fff;
        border: 1px solid #e5e5e5;
        -webkit-border-radius: 5px;
           -moz-border-radius: 5px;
                border-radius: 5px;
        -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.05);
           -moz-box-shadow: 0 1px 2px rgba(0,0,0,.05);
                box-shadow: 0 1px 2px rgba(0,0,0,.05);
      }
      .form-signin .form-signin-heading,
      .form-signin .checkbox {
        margin-bottom: 10px;
      }
      .form-signin input[type="text"],
      .form-signin input[type="password"] {
        font-size: 16px;
        height: auto;
        margin-bottom: 15px;
        padding: 7px 9px;
      }

    </style>
    <link href="lib/bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
    
    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    
    <script type="text/javascript" src="lib/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="lib/bootstrap/js/jquery-latest.js"></script>
   	<script type="text/javascript" src="lib/codemirror.js"></script>
    
	<style type="text/css">
      .CodeMirror { border: 1px solid #eee; }
      td { padding-right: 20px; }
    </style>

</head>
<body>

<div class="container">

	<div class="form-signin">
      
    	<h3 class="form-signin-heading">IKANOW API - Query Generator</h3>
    	
    	<div class="alert">
  			<span class="label label-info">Instructions</span>  The Query Generator demonstrates techniques
  			for developers to use in interacting with the IKANOW Developer API while demonstrating how to formulate
  			the JSON query object to send to the Knowledge - Document Query API. To use the Query Generator:
  			<br><br>
  			<ol>
  				<li>Enter your API key and press the <strong>Get Communities</strong> button.</li>
  				<li>Select the communities you want to search in and press the <strong>Get Sources</strong> button.</li>
  				<li>Select the sources you want to search, search term, and search options then
  					press the <strong>Get Query Object</strong> button.</li>
  			</ol>
  			
  			
		</div>
		
		<table width="100%" cellspacing="0" cellpadding="0">
			<tr valign="top">
				<td width="15%"><span class="label label-info">API Key:</span></td>
				<td width="60%"><input type="text" style="width: 300px;" id="apiKey" placeholder="API Key"></td>
				<td width="25%"><button class="btn" id="getCommunities">Get Communities</button></td>
			</tr>
			<tr valign="top">
				<td><span class="label label-info">Communities:</span></td>
				<td><select id="communitiesList" style="width: 500px;" multiple="multiple"></select></td>
				<td><button class="btn" id="getSources">Get Sources</button></td>
			</tr>
			<tr valign="top">
				<td><span class="label label-info">Sources:</span></td>
				<td colspan="2">
					<select id="sourcesList" style="width: 500px;" multiple="multiple"></select>
				</td>
			</tr>
			<tr valign="top">
				<td></td>
				<td>
					<label class="checkbox">
      					<input type="checkbox" id="excludeSelectedSources"> Exclude selected sources
    				</label>
				</td>
				<td></td>
			</tr>
			<tr valign="top">
				<td><span class="label label-info">Search Term/s:</span></td>
				<td valign="middle">
					<input type="text" id="queryText" style="width: 400px;" placeholder="Search Term/s">
					<select id="searchMode" style="width: 100px;">
  						<option>Free Text</option>
  						<option>Exact Text</option>
					</select>
				</td>
				<td><button class="btn" id="createQuery">Create Query</button></td>
			</tr>
			<tr valign="top">
				<td><span class="label label-info">Post URL:</span></td>
				<td>
					<input type="text" style="width: 98%;" id="postUrl" 
						value="http://api.ikanow.com/api/knowledge/document/query/{communityIds}?infinite_api_key={apiKey}" readonly>
				</td>
				<td><button class="btn" id="postQuery">Post Query</button></td>
			</tr>
			<tr>
				<td colspan="3">
					<textarea id="queryJson" name="queryJson"></textarea>
				</td>
			</tr>
		</table>
		

</div> <!-- /container -->

</body>
</html>

<!---------- CodeMirror JavaScripts ---------->
<script>
	var testEditor = CodeMirror.fromTextArea(document.getElementById("queryJson"), {
		theme: 'default',
	  	lineNumbers: true,
	    matchBrackets: true
	});
</script>

<!---------- JQuery Code ---------->
<script>

	var defaultPostUrl = "http://api.ikanow.com/api/knowledge/document/query/{communityIds}?infinite_api_key={apiKey}";
	
	var apiRoot = "http://api.ikanow.com/";
	$(document).ready(function () {
		$('#postUrl').val(defaultPostUrl);
		
		// Button click handlers
		$("#getCommunities").click(function() { getCommunities(); });
		$("#getSources").click(function() { getSources(); });
		$("#createQuery").click(function() { createQuery(); });
	});
	

	function createQuery()
	{
		var apiKey = $('#apiKey').val();
		var communityList = $('select#communitiesList').val();
		var sourceList = $('select#sourcesList').val();
		var searchMode = $('#searchMode').val();
		var queryText = $('#queryText').val();
		
		var url = $('#postUrl').val();
		url = url.replace("{communityIds}", communityList);
		url = url.replace("{apiKey}", apiKey);
		$('#postUrl').val(url);
		
		// Create Query Object
		var queryObject = new Object();

		// Create queryObject.qt object
		queryObject.qt = new Object();
		if (searchMode == "Free Text") {
			queryObject.qt.ftext = queryText;	
		}
		else {
			queryObject.qt.etext = queryText;	
		}
		
		// Create queryObject.input object if needed
		// queryObject.input = new Object();
		
		testEditor.setValue(JSON.stringify(queryObject,null,'\t'));
	}
	
	
	function getSources()
	{
		$('#postUrl').val(defaultPostUrl);
		var communityList = $('select#communitiesList').val();
		
		var apiKey = $('#apiKey').val();
		if (apiKey.length > 0) {
			// API Call - Get list of good sources that are owned by the selected communities
			
			var apiCall = apiRoot + "api/config/source/good/" + communityList + "?infinite_api_key=" + apiKey;
			var response = $.ajax({
				type: 'GET',
				url: 'get.jsp?addr=' + apiCall,
				async: false,
				contentType: "application/json",
				dataType: 'text'
			});
			response.done(function(msg) {
				jsonResponse = msg;
			});
	
			if (jsonResponse.length > 0) {
				var jsonObj = jQuery.parseJSON(jsonResponse);
				
				//testEditor.setValue(JSON.stringify(jsonObj,null,'\t'));
				
				if (jsonObj.response.success == true) {
					var sources = jsonObj.data;
					var sourcesContainer = $('#sourcesList');
					sourcesContainer.empty();
					
					for (var i=0; i < sources.length; i++) {
						var source = sources[i];
						$('#sourcesList').append($('<option>', { value: source.key, text : source.title }));
					}
				}
			}
		}
	}
	
	
	
	function getCommunities()
	{
		$('#postUrl').val(defaultPostUrl);
		var apiKey = $('#apiKey').val();
		if (apiKey.length > 0) {
			// API Call - Person Get to return person object for user with API key passed in
			var apiCall = apiRoot + "api/social/person/get?infinite_api_key=" + apiKey;
			var response = $.ajax({
				type: 'GET',
				url: 'get.jsp?addr=' + apiCall,
				async: false,
				contentType: "application/json",
				dataType: 'text'
			});
			response.done(function(msg) {
				jsonResponse = msg;
			});
	
			if (jsonResponse.length > 0) {
				var jsonObj = jQuery.parseJSON(jsonResponse);
				
				//testEditor.setValue(JSON.stringify(jsonObj,null,'\t'));
				
				if (jsonObj.response.success == true) {
					var communities = jsonObj.data.communities;
					var communityContainer = $('#communitiesList');
					communityContainer.empty();
					
					for (var i=0; i < communities.length; i++) {
						var community = communities[i];
						$('#communitiesList').append($('<option>', { value: community._id, text : community.name }));
					}
				}
			}
		}
	}
	

	
</script>