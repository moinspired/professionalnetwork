


<div class="mid-section">
	<h4>Your Professional Network:</h4>
	<div class="myConnection">
		<c:forEach var="network" items="${networks}">
			<p>
				<a href="user/${network.id}">${network.getName()}</a>
			</p>
		</c:forEach>
	</div>
</div>