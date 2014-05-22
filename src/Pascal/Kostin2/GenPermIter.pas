program GenPermIterative;

const
	n = 4;   {n порядок перестановок}

var
	p: array [0..n] of 0..n;
	k: 0..n;
	j, r: 1..n;

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

begin
	for k:=0 to n do
		p[k] := k; {задание начальной перестановки}
	k := 1;
	while k <> 0 do
	begin
		for k:=1 to n do
			write(p[k]);
		writeln;     {вывод перестановки}
		k := n-1;
		while p[k] > p[k+1] do
			k := k-1;             {поиcк k}
		j := n;
		while p[k] > p[j] do
			j := j-1;                       {поиск j}
		r := p[k];
		p[k] := p[j];
		p[j] := r;                {транспозиция рк и pj }
		invert(k+1);            {инвертирование хвоста перестановки}
	end;
end. 
