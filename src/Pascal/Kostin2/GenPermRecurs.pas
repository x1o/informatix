program GenPermRecursive;

const
	n = 4;   {n порядок перестановок}

var
	p: array [1..n] of 1..n;
	i, r: 1..n;

procedure Invert(m: integer); {инвертирование p[m]...p[n] }
var
	i, j: 1..n;
begin
	i := m;
	j := n;
	while i < j do
	begin
		r := p[i];
		p[i] := p[j];
		p[j] := r;
		i := i+1;
		j := j-1;
	end;
end;

procedure Lec (k: integer);
var
	j: 1..n;
begin
	if k = n then
	begin
		for i:=1 to n do
			write (p[i]);
		writeln;
	end
	else
	for j := n downto k do
	begin
		LEC(k+1);
		if j <> k then
		begin
			r := p[j];
			p[j] := p[k];
			p[k] := r;
			Invert(k+1)
		end
	end
end;

begin
	for i:=1 to n do
		p[i] := i;
	LEC(1);
end.
