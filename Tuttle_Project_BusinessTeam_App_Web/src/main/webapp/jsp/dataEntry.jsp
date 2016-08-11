<!DOCTYPE HTML>
<html>
<head>
<script type="text/javascript" src="./js/jquery-3.1.0.min.js"></script>
<script type="text/javascript" src="./docSpec/docSpec1.js"></script>
<script type="text/javascript" src="./xonomy/xonomy.js"></script>
<link type="text/css" rel="stylesheet" href="./xonomy/xonomy.css" />
<link type="text/css" rel="stylesheet" href="./css/tuttle.css" />

<script type="text/javascript">
	var setMode = function() {
		var mode = $("input[name='mode']:checked").val();
		Xonomy.setMode(mode);
	};
	var handleResponse = function(status, xmlData) {
		startMain(xmlData);
	};
	var handleStateChange = function() {
		switch (xmlhttp.readyState) {
		case 0: // UNINITIALIZED
		case 1: // LOADING
		case 2: // LOADED
		case 3: // INTERACTIVE
			break;
		case 4: // COMPLETED
			handleResponse(xmlhttp.status, xmlhttp.responseText);
			break;
		default:
			alert("error");
		}
	}
	var xmlhttp = new XMLHttpRequest();
	xmlhttp.onreadystatechange = handleStateChange;
	var xmlURL = window.location.protocol + "//" + window.location.host
			+ "/TPBTeam/xml/sample.xml";
	xmlhttp.open("GET", xmlURL, true);
	xmlhttp.send(null);

	var startMain = function(xmlData) {
		var docSpec = {
			onchange : function() {
				console.log("I been changed now!")
			},
			validate : function(obj) {
				console.log("I be validatin' now!")
			},
			elements : {
				"DOCUMENT" : {
					menu : [ {
						caption : "Append an <DATA>",
						action : Xonomy.newElementChild,
						actionParameter : "<DATA/>"
					} ],

				},
				"STRUCT" : {
					menu : [ {
						caption : "Add @label=\"m\"",
						action : Xonomy.newAttribute,
						actionParameter : {
							name : "label",
							value : "m"
						},/* 
													hideIf : function(jsElement) {
														return jsElement.hasAttribute("label");
													} */
					}, {
						caption : "Delete this <STRUCT>",
						action : Xonomy.deleteElement
					}, {
						caption : "New <STRUCT> ",
						action : Xonomy.newElementAfter,
						actionParameter : "<STRUCT/>"
					}, {
						caption : "Add All Elements of <STRUCT>",
						action : Xonomy.insertElements,
						actionParameter : [ "<SNAME/>", "<FNAME/>" ]
					} ],
					canDropTo : [ "DATA" ],
					attributes : {
						"label" : {
							asker : Xonomy.askString,
							menu : [ {
								caption : "Delete this @label",
								action : Xonomy.deleteAttribute
							} ]
						},
						"label" : {
							asker : Xonomy.askPicklist,
							askerParameter : [ {
								value : "m",
								caption : "male"
							}, {
								value : "f",
								caption : "female"
							} ]
						}
					}
				},
				"DATA" : {
					menu : [ {
						caption : "Delete this <DATA>",
						action : Xonomy.deleteElement
					}, {
						caption : "New <STRUCT> ",
						action : Xonomy.insertElements,
						actionParameter : [ "<STRUCT/>" ]
					} ],
					canDropTo : [ "DOCUMENT" ],
					attributes : {
						"label" : {
							asker : Xonomy.askString,
							menu : [ {
								caption : "Delete this @label",
								action : Xonomy.deleteAttribute
							} ]
						}
					}
				},
				"SNAME" : {
					canDropTo : [ "STRUCT" ]
				},
				"FNAME" : {
					canDropTo : [ "STRUCT" ]
				}
			}
		};

		var editor = document.getElementById("editor");
		setMode();
		Xonomy.render(xmlData, editor, docSpec);
	};
	var submit = function() {
		var xml = Xonomy.harvest();
	}
</script>
</head>
<body onload="handleResponse">
	<div class="setters">
		<span class="radios"> <label onclick="setMode()"> <input
				type="radio" id="mode" name="mode" value="nerd" id="chkModeNerd"
				checked="checked" />Nerd mode
		</label> <label onclick="setMode()"> <input type="radio" name="mode"
				value="laic" id="chkModeLaic" />Laic mode
		</label>
		</span>
	</div>
	<br>
	<br>
	<div class="editorContainer">
		<div id="editor" class="scrollable-content"  style="display: block;font-family: Georgia, serif; font-size: 70%;"></div>
	</div>
	
	<div class="downloads">
		<button class="submitter" onclick="submit()">Generate XML</button>
	</div>
</body>
</html>
