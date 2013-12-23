program Josephus;

function J(q: integer; n: integer): integer;
begin
	if n = 1 then
		exit(0)
	else
		exit((J(q, n-1) + q) mod n);
end;

begin
	writeln(J(2, 3));
	writeln(J(3, 4));
	writeln(J(3, 5));
	writeln(J(2, 5));
	writeln(J(3, 7));
end.
