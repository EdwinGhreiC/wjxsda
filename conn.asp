<%@Language=VBScript codepage=65001 %>
<% response.buffer=true	
dim conn
dim connstr
dim db

ADMIN_GRADE = 3

'db="database\data23094.accdb"
db="database\data23094.mdb"
Set conn = Server.CreateObject("ADODB.Connection")
'connstr="Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" & Server.MapPath(db) & ";Persist Security Info=False;"
'=====mdb专用====='
connstr="Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath(db)
conn.open connstr

sub closeconn()
	conn.close
	set conn=nothing
end sub
%>


