/******************************************************************************
 qForm JSAPI: CFFORM Validation Library

 Author: Dan G. Switzer, II
 Build:  100
******************************************************************************/
qFormAPI.packages.cfform = true;

_addValidator(
	"isBoolean",
	function (){
		if( 
			(this.value.toUpperCase() != "TRUE") 
			|| (this.value.toUpperCase() != "FALSE") 
			|| (this.value.toUpperCase() != "YES") 
			|| (this.value.toUpperCase() != "NO") 
			|| (this.value != "0") 
			|| (this.value != "1") 
		){
			this.error = "The " + this.description + " field does not contain a boolean value.";
		}
	}	
);

/**
 * A string GUID value is required. A GUID is a string
 * of length 36 formatted as XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX, where X is a
 * hexadecimal digit (0-9 or A-F).
 */
_addValidator(
	"isGUID",
	function (){
		var v = _trim(this.value);
		if( !(/[A-Fa-f0-9]{8,8}-[A-Fa-f0-9]{4,4}-[A-Fa-f0-9]{4,4}-[A-Fa-f0-9]{4,4}-[A-Fa-f0-9]{12,12}/.test(v)) ){
			this.error = "The " + this.description + " field does not contain a valid GUID.";		
		}
	}	
);

/**
 * A string UUID value is required. A UUID is a string
 * of length 35 formatted as XXXXXXXX-XXXX-XXXX-XXXXXXXXXXXXXXXX, where X is a
 * hexadecimal digit (0-9 or A-F).
 */
_addValidator(
	"isUUID",
	function (){
		var v = _trim(this.value);
		if( !(/[A-Fa-f0-9]{8,8}-[A-Fa-f0-9]{4,4}-[A-Fa-f0-9]{4,4}-[A-Fa-f0-9]{16,16}/.test(v)) ){
			this.error = "The " + this.description + " field does not contain a valid GUID.";		
		}
	}	
);


/**
 * validate that the value is formatted correctly for a http/https/ftp url
 * This pattern will match http/https/ftp urls.
 *
 * Matches: http://www.mm.com/index.cfm
 *          HTTP://WWW.MM.COM
 *          http://www.mm.com/index.cfm?userid=1&name=mike+nimer
 *          http://www.mm.com/index.cfm/userid/1/name/mike+nimer - trick used by cf developers so search engines can parse their sites (search engines ignore query strings)
 *          ftp://www.mm.com/
 *          ftp://uname:pass@www.mm.com/
 *          mailto:email@address.com
 *          news:rec.gardening
 *          news:rec.gardening
 *          http://a/
 *			    file://ftp.yoyodyne.com/pub/files/foobar.txt
 * Non-Matches: www.yahoo.com
 *              http:www.mm.com
 *
 */
_addValidator(
	"isURL",
	function (){
		var v = _trim(this.value).toLowerCase();
		if( !(/^((http|https|ftp|file)\:\/\/([a-zA-Z0-0]*:[a-zA-Z0-0]*(@))?[a-zA-Z0-9-\.]+(\.[a-zA-Z]{2,3})?(:[a-zA-Z0-9]*)?\/?([a-zA-Z0-9-\._\?\,\'\/\+&amp;%\$#\=~])*)|((mailto)\:[\w-]+(?:\.[\w-]+)*@(?:[\w-]+\.)+[a-zA-Z0-9]{2,7})|((news)\:[a-zA-Z0-9\.]*)$/.test(v)) ){
			this.error = "The " + this.description + " field does not contain a valid URL.";		
		}
	}	
);


/**
 * A string UUID value is required. A UUID is a string
 * of length 35 formatted as XXXXXXXX-XXXX-XXXX-XXXXXXXXXXXXXXXX, where X is a
 * hexadecimal digit (0-9 or A-F).
 */
_addValidator(
	"isRegEx",
	function (r){
		var v = _trim(this.value);
		if( !(r.test(v)) ){
			this.error = "The " + this.description + " field contains invalid data.";		
		}
	}	
);

/**
 * validate that the value is formatted as a telephone correctly
 * This pattern matches any US Telephone Number.
 * This regular expression excludes the first number, after the area code,from being 0 or 1;
 * it also allows an extension to be added where it does not have to be prefixed by 'x'.
 *
 * Matches: 
 * 617.219.2000 
 * 219-2000
 * (617)283-3599 x234
 * 1(222)333-4444
 * 1 (222) 333-4444
 * 222-333-4444
 * 1-222-333-4444
 * Non-Matches: 
 * 44-1344-458606
 * +44-1344-458606
 * +34-91-397-6611
 * 7-095-940-2000
 * +7-095-940-2000
 * +49-(0)-889-748-5516
*/
_addValidator(
	"isUSPhone",
	function (){
		var v = _trim(this.value);
		if( !(/^(((1))?[ ,\-,\.]?([\\(]?([1-9][0-9]{2})[\\)]?))?[ ,\-,\.]?([^0-1]){1}([0-9]){2}[ ,\-,\.]?([0-9]){4}(( )((x){0,1}([0-9]){1,5}){0,1})?$/.test(v)) ){
			this.error = "The " + this.description + " field does not contain a valid phone number.";		
		}
	}	
);


_addValidator(
	"isTime",
	function (){
		var aTime = this.value.split(":");
		var isTime = true;

		if( (this.value.length == 0) || (aTime.length != 2) ) isTime = false;
		
		if( isTime ){
			var sHour = aTime[0];
			var iHour = parseInt(sHour, 10);
			var sMinute = aTime[1];
			var iMinute = parseInt(sMinute, 10);
			
			if( (sHour != String(iHour)) || (sMinute != String(iMinute)) ) isTime = false;
			else if( (iHour < 0) || (iHour > 23) ) isTime = false;
			else if( (iMinute < 0) || (iMinute > 59) ) isTime = false;
		}
		
		if( !isTime ){
			this.error = "The " + this.description + " field does not contain a valid time.";
		}
	}	
);

_addValidator(
	"isInt",
	function (){
		var v = this.value;
		var isNumeric = (v == String(parseFloat(v, 10)));
		if( !isNumeric || (parseInt(v, 10) != parseFloat(v, 10)) ){
			this.error = "The " + this.description + " field must contain an integer value.";
		}
	}	
);

_addValidator(
	"isFloat",
	function (){
		var v = this.value;
		var isNumeric = (v == String(parseFloat(v, 10)));
		if( !isNumeric || (parseInt(v, 10) == parseFloat(v, 10)) ){
			this.error = "The " + this.description + " field must contain an floating number.";
		}
	}	
);

_addValidator(
	"isNumber",
	function (){
		var v = this.value;
		if( v != String(parseFloat(v, 10)) ){
			this.error = "The " + this.description + " field must contain a valid number.";
		}
	}	
);


