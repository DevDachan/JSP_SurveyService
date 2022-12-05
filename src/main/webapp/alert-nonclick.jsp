
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import='java.net.URLDecoder' %>
<%
	request.setCharacterEncoding("UTF-8");
	String title =URLDecoder.decode(request.getParameter("title"), "UTF-8");
	String content = URLDecoder.decode(request.getParameter("content"), "UTF-8");
	String url = URLDecoder.decode(request.getParameter("url"), "UTF-8");
	String id = URLDecoder.decode(request.getParameter("id"), "UTF-8");
	
%>
<a id="<%=id%>Modal" data-toggle="modal" href="#Modal" style="display:none;"></a>	
	


<div class="modal fade" id="Modal" tabindex="-1" data-backdrop="static" data-keyboard="false" role="dialog" aria-labelledby="modal" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id ="modal">
					<%=title %>
				</h5>
				<button type="button" class="close" data-dismiss="modal" onClick="<%=url%>" aria-label="Close" >
				<span aria-hidden="true">&times;</span>
				</button>	
			</div>
			
			<div class="modal-body">
				<div class="form-row">
					<div class="form-group col-sm-12">
						<label><%=content %></label>
					</div>		
					<div class="modal-footer col-sm-12">
						<div class="form-group col-sm-12">
							<button type="button" id="close_modal" class="btn btn-secondary" style="width:100%;" data-dismiss="modal" onClick="<%=url%>">close</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>