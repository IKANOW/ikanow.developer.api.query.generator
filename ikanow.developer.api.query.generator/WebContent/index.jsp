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
	<title>IKANOW API - Query Generator</title>

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
  			<p>The IKANOW API - Query Generator is an interactive tool useful for learning how to write query
  			objects for the Document Query API (as well as demonstrating simple techniques for developing applications
  			that interact with the <a href="http://developer.ikanow.com">IKANOW Developer API</a> 
  			using JavaScript and JSP).</p> 
  			
			<span class="label label-info">Instructions</span>
  			<ol>
  				<li>Enter your API key and press the <strong>Get Communities</strong> button.</li>
  				<li>Select the communities you want to search in and press the <strong>Get Sources</strong> button.</li>
  				<li>Select the sources you want to search (Note: if you don't select a source all sources in the
  					select list will be searched), search term, and search options then
  					press the <strong>Create Query</strong> button. (Hint: Click on the <i class="icon-info-sign"></i> icon for
  					a section to view the corresponding technical documentation for each object.)</li>
  				<li>Copy the post URL and Body fields into your application, curl, or the Interactive API Documentation
  					on the developer web site: <a href="http://developer.ikanow.com/io-docs">http://developer.ikanow.com/io-docs</a>.</li>
  			</ol>
		</div>
		
		<table width="100%" cellspacing="0" cellpadding="8">
			<tr valign="top" style="border-bottom-width: 1px; border-bottom-style:dotted; border-bottom-color:#DADADA;">
				<td colspan="3"><h4>URL Arguments <a href="http://developer.ikanow.com/docs/read/Querying_Documents"
					target="blank"><i class="icon-info-sign"></i></a></h4> </td>
			</tr>
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
			<tr valign="top" style="border-bottom-width: 1px; border-bottom-style:dotted; border-bottom-color:#DADADA;">
				<td colspan="3"><h4>Input Options <a href="http://developer.ikanow.com/docs/read/Querying__Input_Options"
					target="blank"><i class="icon-info-sign"></i></a></h4></td>
			</tr>
			<tr valign="top">
				<td><span class="label label-info">Sources:</span></td>
				<td valign="top">
					<select id="sourcesList" style="width: 500px;" multiple="multiple"></select></td>
				<td><input type="checkbox" id="excludeSelectedSources"> Exclude selected sources</td>
			</tr>
			<tr valign="top">
				<td><span class="label label-info">Source Type:</span></td>
				<td colspan="2">
					<select id="sourceType" style="width: 300px;">
  						<option>Any</option>
  						<option>Blog</option>
  						<option>Database</option>
  						<option>Other</option>
					</select>	
				</td>
			</tr>
			<tr valign="top">
				<td><span class="label label-info">Source Tags:</span></td>
				<td>
					<input type="text" id="queryTags" style="width: 400px;" placeholder="List of ',' separated tags">	
				</td>
				<td></td>
			</tr>
			<tr valign="top" style="border-bottom-width: 1px; border-bottom-style:dotted; border-bottom-color:#DADADA;">
				<td colspan="3"><h4>Query Term/s <a href="http://developer.ikanow.com/docs/read/Querying__Query_Terms"
					target="blank"><i class="icon-info-sign"></i></a></h4></td>
			</tr>
			<tr valign="top">
				<td><span class="label label-info">Query Term/s:</span></td>
				<td valign="middle">
					<input type="text" id="queryText" style="width: 400px;" placeholder="Search Term/s">
					<select id="searchMode" style="width: 100px;">
  						<option>Free Text</option>
  						<option>Exact Text</option>
					</select>
				</td>
				<td></td>
			</tr>
			<tr valign="top" style="border-bottom-width: 1px; border-bottom-style:dotted; border-bottom-color:#DADADA;">
				<td colspan="3"><h4>Output Options <a href="http://developer.ikanow.com/docs/read/Querying__Output_Options"
					target="blank"><i class="icon-info-sign"></i></a></h4></td>
			</tr>
			<tr valign="top">
				<td><span class="label label-info">Output Format:</span></td>
				<td>
					<select id="outputFormat" style="width: 250px;">
  						<option>JSON</option>
  						<option>XML</option>
  						<option>RSS</option>
					</select>
				</td>
				<td></td>
			</tr>
			<tr valign="top">
				<td><span class="label label-info">Documents to Return:</span></td>
				<td colspan="2">
					<input type="text" id="numberOfDocs" style="width: 200px;" placeholder="Number Of Docs">
					<input type="text" id="numberToSkip" style="width: 200px;" placeholder="Number To Skip">
				</td>
			</tr>
			<tr valign="top">
				<td><span class="label label-info">Include:</span></td>
				<td colspan="2">
					<input type="checkbox" id="includeEnts" checked> Entities &nbsp;&nbsp;
					<input type="checkbox" id="includeEvents" checked> Events &nbsp;&nbsp;
					<input type="checkbox" id="includeGeo" checked> Geo &nbsp;&nbsp;
					<input type="checkbox" id="includeFacts" checked> Facts &nbsp;&nbsp;
					<input type="checkbox" id="includeSummaries" checked> Summaries &nbsp;&nbsp;
					<input type="checkbox" id="includeMetadata" checked> Metadata
					
				</td>
			</tr>
			
			<tr valign="top">
				<td><span class="label label-info">Filter:</span></td>
				<td colspan="2">
					<input type="text" id="entityTypes" style="width: 300px;" placeholder="List of ',' separated entity types">
					<input type="text" id="verbCats" style="width: 300px;" placeholder="List of ',' separated verb categories">
				</td>
			</tr>

			<tr valign="top" style="border-bottom-width: 1px; border-bottom-style:dotted; border-bottom-color:#DADADA;">
				<td colspan="3"><h4>Scoring Options <a href="http://developer.ikanow.com/docs/read/Querying__Scoring_Params"
					target="blank"><i class="icon-info-sign"></i></a></h4></td>
			</tr>
			
			<tr valign="top">
				<td><span class="label label-info">Number to Analyze:</span></td>
				<td colspan="2">
					<input type="text" id="numAnalyze" style="width: 150px;" placeholder="Number">
				</td>
			</tr>
			<tr valign="top">
				<td><span class="label label-info">Weighting:</span></td>
				<td colspan="2">
					<input type="text" id="sigWeight" style="width: 150px;" placeholder="Signifigance">
					<input type="text" id="relWeight" style="width: 150px;" placeholder="Relevance">
				</td>
			</tr>
			<tr valign="top">
				<td><span class="label label-info">Time Proximity:</span></td>
				<td colspan="2">
					<input type="text" id="timeProx" style="width: 225px;" placeholder="Time">
					<input type="text" id="timeDecay" style="width: 75px;" placeholder="Decay">
				</td>
			</tr>
			<tr valign="top">
				<td><span class="label label-info">Geospatial Proximity:</span></td>
				<td colspan="2">
					<input type="text" id="latLon" style="width: 200px;" placeholder="Latitude,Longitude">
					<input type="text" id="latLonDecay" style="width: 100px;" placeholder="Decay">
				</td>
			</tr>


			
			<tr valign="top" style="border-bottom-width: 1px; border-bottom-style:dotted; border-bottom-color:#DADADA;">
				<td colspan="3"><h4>Post URL and Body</h4></td>
			</tr>
			<tr valign="top">
				<td><span class="label label-info">Post URL:</span></td>
				<td>
					<input type="text" style="width: 98%;" id="postUrl" 
						value="http://api.ikanow.com/api/knowledge/document/query/{communityIds}?infinite_api_key={apiKey}" readonly>
				</td>
				<td>
					<button class="btn" id="createQuery">Create Query</button>
					<!-- <button class="btn" id="postQuery">Post Query</button> -->
				</td>
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
		var excludeSources = $("#excludeSelectedSources").is(':checked');
		var sourceType = $('#sourceType').val();
		var tags = $('#queryTags').val();
		var searchMode = $('#searchMode').val();
		var queryText = $('#queryText').val();
		
		// Create URL
		var url = $('#postUrl').val();
		url = url.replace("{communityIds}", communityList);
		url = url.replace("{apiKey}", apiKey);
		$('#postUrl').val(url);
		
		// Create Query Object
		var queryObject = new Object();

		// Start Create queryObject.qt object
		queryObject.qt = new Array();
		if (searchMode == "Free Text") { queryObject.qt[0] = {"ftext" : queryText}; }
		else { queryObject.qt[0] = {"etext" : queryText}; }
		// End Create queryObject.qt object
		
		
		// Start Create queryObject.input
		var sourceListArray = new Array();
		if (sourceList != null && sourceList.length > 0) {
			for (var i=0; i < sourceList.length; i++) {
				var source = sourceList[i];
				sourceListArray[i] = source;
			}
		}
		
		if (sourceType == "Any") { sourceType = ""; }
		if ( sourceListArray.length > 0 || tags.length > 0 || sourceType.length > 0 ) {
			queryObject.input = new Object();
			
			if (sourceListArray.length > 0) { queryObject.input.sources = sourceListArray; }
			if (excludeSources) queryObject.input.srcInclude = false;
			
			var tagArray = new Array();
			if (tags.length > 0) { tagArray = tags.split(","); }
			
			if (sourceType.length > 0 && tagArray.length > 0) {
				queryObject.input.typesAndTags = new Object();
				queryObject.input.typesAndTags.type = sourceType;
				queryObject.input.typesAndTags.tags = tagArray;
			}
			else if (sourceType.length > 0) {
				queryObject.input.typesAndTags = new Object();
				queryObject.input.typesAndTags.type = sourceType;
			}
			else if (tagArray.length > 0) {
				queryObject.input.tags = tagArray;
			}
		}
		// End Create queryObject.input
		
		
		// Start Create queryObject.output
		var outputFormat = $('#outputFormat').val();
		var numberOfDocs = $('#numberOfDocs').val();
		var numberToSkip = $('#numberToSkip').val();
		var includeEnts = $("#includeEnts").is(':checked');
		var includeEvents = $("#includeEvents").is(':checked');
		var includeGeo = $("#includeGeo").is(':checked');
		var includeFacts = $("#includeFacts").is(':checked');
		var includeSummaries = $("#includeSummaries").is(':checked');
		var includeMetadata = $("#includeMetadata").is(':checked');
		var entityTypes = $('#entityTypes').val();
		var verbCats = $('#verbCats').val();
		
		if (outputFormat != "JSON" || numberOfDocs.length > 0 || numberToSkip.length > 0 || 
				includeEnts != true || includeEvents != true || includeGeo != true ||
				includeFacts != true || includeSummaries != true || includeMetadata != true ||
				entityTypes.length > 0 || verbCats.length > 0) {
			
			queryObject.output = new Object();
			
			if (outputFormat != "JSON") { queryObject.output.format = outputFormat; }
			
			if (numberOfDocs.length > 0 || numberToSkip.length > 0 || 
					includeEnts != true || includeEvents != true || includeGeo != true ||
					includeFacts != true || includeSummaries != true || includeMetadata != true ||
					entityTypes.length > 0 || verbCats.length > 0) { queryObject.output.docs = new Object(); }
			
			if (numberOfDocs.length > 0 && isInt(numberOfDocs)) { queryObject.output.docs.numReturn = parseInt(numberOfDocs); }
			if (numberToSkip.length > 0 && isInt(numberToSkip)) { queryObject.output.docs.skip = parseInt(numberToSkip); }
			if (!includeEnts) { queryObject.output.docs.ents = false; }
			if (!includeEvents) { queryObject.output.docs.events = false; }
			if (!includeGeo) { queryObject.output.docs.geo = false; }
			if (!includeFacts) { queryObject.output.docs.facts = false; }
			if (!includeSummaries) { queryObject.output.docs.summaries = false; }
			if (!includeMetadata) { queryObject.output.docs.metadata = false; }
			
			if (entityTypes.length > 0) {
				queryObject.output.filter = new Object();
				queryObject.output.filter.entityTypes = entityTypes.split(","); 
			}
			if (verbCats.length > 0) {
				if (typeof queryObject.output.filter == 'undefined') { queryObject.output.filter = new Object(); }
				queryObject.output.filter.assocVerbs = verbCats.split(","); 
			}
			// End Create queryObject.output
		}
		// END Create queryObject.output
		
		// Start create queryObject.score
		var numAnalyze = $('#numAnalyze').val();
		var sigWeight = $('#sigWeight').val();
		var relWeight = $('#relWeight').val();
		var timeProx = $('#timeProx').val();
		var timeDecay = $('#timeDecay').val();
		var latLon = $('#latLon').val();
		var latLonDecay = $('#latLonDecay').val();
		
		if (numAnalyze.length > 0 || sigWeight.length > 0 || relWeight.length > 0 || timeProx.length > 0 ||
				timeDecay.length > 0 || latLon.length > 0 || latLonDecay.length > 0) {
			
			queryObject.score = new Object();
				
			if (numAnalyze.length > 0 && isInt(numAnalyze)) { queryObject.score.numAnalyze = parseInt(numAnalyze); }
			if (sigWeight.length > 0  && !isNaN(sigWeight)) { queryObject.score.sigWeight = parseFloat(sigWeight); }
			if (relWeight.length > 0  && !isNaN(relWeight)) { queryObject.score.relWeight = parseFloat(relWeight); }
			if (timeProx.length > 0) {
				queryObject.score.timeProx = new Object();
				queryObject.score.timeProx.time = timeProx;
				if (timeDecay.length > 0) { queryObject.score.timeProx.duration = timeDecay; }
			}
			if (latLon.length > 0) {
				queryObject.score.geoProx = new Object();
				queryObject.score.geoProx.ll = latLon;
				if (latLonDecay.length > 0) { queryObject.score.geoProx.decay = latLonDecay; }
			}
				
		}
		// End create queryObject.score
		
		
		// Write queryObject to codemirror textbox
		testEditor.setValue(JSON.stringify(queryObject,null,'\t'));
	}
	
	function isInt(value) { 
	    return !isNaN(parseInt(value)) && (parseFloat(value) == parseInt(value)); 
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