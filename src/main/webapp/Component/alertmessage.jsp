<%@page import="com.eazydelzs.entities.Message"%>
<%
Message messg = (Message) session.getAttribute("message");
if (messg != null) {
%>
<div class="alert <%=messg.getCssClass()%>" role="alert" id="alert" aria-live="assertive" aria-atomic="true">
	<%=messg.getMessage()%>
</div>
<%
session.removeAttribute("message");
}
%>
<script type="text/javascript">
	// Automatically close the alert message after 3 seconds
	setTimeout(function() {
		$('#alert').fadeOut('slow', function() {
			$(this).alert('close');
		});
	}, 3000);
</script>
