<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="language" 						 content="english">
	<meta name="author" 						   content="Agung Sukarno">
	<meta http-equiv="window-target"   content="_top">
	<meta name ='viewport' 					   content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no'>

	{{block name=meta}}
	<meta name="revisit-after" content="1 days">
	<meta name="keywords" content="kurator,indonesia,putusan,pengadilan,polisi,pidana,perdata,hukuman,penjara,kurungan">
	<meta name="description" content="This website is aim for people who are interested in law, we combine information technology and indonesian law.">
	{{/block}}

	{{* CSS template *}}
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
	{{block name=addoncss}}{{/block}}

	{{* CSS Style *}}
	{{block name=stylecss}}{{/block}}

	<title>{{block name=title}}Indonesian Index Application Law{{/block}}</title>
</head>
<body>

	{{* Content template *}}
	{{block name=content}}{{/block}}

	{{* Footer template *}}
	{{block name=footer}}{{/block}}

	<script src="https://code.jquery.com/jquery-2.2.4.min.js" integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44=" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
	
	{{* JS template *}}
	{{block name=addonjs}}{{/block}}

	{{* JS Script *}}
	{{block name=scriptjs}}{{/block}}
</body>
</html>