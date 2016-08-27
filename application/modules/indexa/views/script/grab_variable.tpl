{{extends file="../template/layout.tpl"}}

{{block name= title}}
	Grab Variables
{{/block}}


{{block name= content}}
	<PRE>
	{{print_r($variables)}}
	</PRE>
{{/block}}