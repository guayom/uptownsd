/*!
 * froala_editor v1.2.8 (https://www.froala.com/wysiwyg-editor)
 * License https://www.froala.com/wysiwyg-editor/terms
 * Copyright 2014-2015 Froala Labs
 */

!function(a){a.Editable.prototype.refreshFontSize=function(){var b=a(this.getSelectionElement()),c=parseInt(b.css("font-size").replace(/px/g,""),10)||16;this.$editor.find('.fr-dropdown > button[data-name="fontSize"] + ul li').removeClass("active"),this.$editor.find('.fr-dropdown > button[data-name="fontSize"] + ul li[data-val="'+c+'px"]').addClass("active")},a.Editable.commands=a.extend(a.Editable.commands,{fontSize:{title:"Font Size",icon:"fa fa-text-height",refreshOnShow:a.Editable.prototype.refreshFontSize,seed:[{min:11,max:52}],undo:!0,callback:function(a,b){this.inlineStyle("font-size",a,b)},callbackWithoutSelection:function(a,b){this._startInFontExec("font-size",a,b)}}}),a.Editable.prototype.command_dispatcher=a.extend(a.Editable.prototype.command_dispatcher,{fontSize:function(a){var b=this.buildDropdownFontsize(a),c=this.buildDropdownButton(a,b);return c}}),a.Editable.prototype.buildDropdownFontsize=function(a){for(var b='<ul class="fr-dropdown-menu f-font-sizes">',c=0;c<a.seed.length;c++)for(var d=a.seed[c],e=d.min;e<=d.max;e++)b+='<li data-cmd="'+a.cmd+'" data-val="'+e+'px"><a href="#"><span>'+e+"px</span></a></li>";return b+="</ul>"}}(jQuery);
