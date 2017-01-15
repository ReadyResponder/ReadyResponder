# Available helpdocs

<% @files.each do |f| %>
* [<%=f%>](/helpdocs/<%=URI.encode f%>)
<% end %>
