
addEvent(window, 'load', function()
{
	var counts = document.getElementsByClassName('wordcount');
	var i, countHolder;
	
	for (i=0; i<counts.length; i++)
	{
		count = counts[i];	
		count.holder = document.getElementById(count.id + '_wordcount');
		if (!count.holder)
			continue;
			
		count.holder.innerHTML = numWords(count.value);
		count.onkeyup = function()
		{
			this.holder.innerHTML = numWords(this.value);
		}
	}
});

function numWords(string)
{
	string = string + ' ';
	string = string.replace(/^[^A-Za-z0-9]+/gi, "");
	string = string.replace(/[^A-Za-z0-9]+/gi, " ");
	var items = string.split(" ");
	return items.length -1;
}