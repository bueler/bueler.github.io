<div class="x-scroll">
<table class="asst-table">
<tr><th>Assignment</th><th>Due</th><th>Problems</th></tr>
{% for asst in include.data %}
<tr style="">
<td>{{asst.name}}</td><td>{{asst.due}}</td>
<td>
{% for part in asst.problems} %}
<b>{{part.section}}:</b> {{part.exercises}}<br>
{% endfor %}
</td>
</tr>
{% endfor %}
</table>
</div>