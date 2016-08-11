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