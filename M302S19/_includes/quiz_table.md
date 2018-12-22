{% assign data = include.data %}
<table class="asst-table">
{% for quiz in data.quizzes %}
<tr>
	<td>{{ quiz.name }}</td>
	<td> 
		{% for v in quiz.versions %}		
		<table class="inner"><tr><td>{{ v.name }}:</td><td><a href="{{ data.home }}/{{ v.blank }}">blank</a></td></tr>
			<tr><td></td><td><a href="{{ data.home }}/{{ v.solutions }}">solutions</a></td></tr>
		</table>
		<div style="padding-bottom: 10px"></div>
		{% endfor %}
	</td>
</tr>
{% endfor %}
</table>
