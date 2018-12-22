{% for quiz in include.data %}
### {{quiz.name}}

<table style="border-spacing:10px">
{% for v in quiz.versions %}
<tr>
	<td>{{ v.name }}:</td>
	<td> <a href="{{quiz.home}}/{{v.blank}}">blank</a></td>
	<td> <a href="{{quiz.home}}/{{v.solutions}}">solutions</a></td>
</tr>
{% endfor %}
</table>
{% endfor %}
