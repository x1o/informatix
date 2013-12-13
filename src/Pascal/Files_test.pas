program PrintFamilyNameNotSh;

var
	i, n: integer;
	{ f: file of string; }
	f: textfile;
	s: string;

begin
	assign(f, '../../data/Family_names.txt');
	reset(f);
	while not(eof(f)) do
	begin
		readln(f, s);
		{ write('* (', s[1], ') '); }
		{ writeln(Length(s)); }
		{ if s[1] <> 'Ø' then }
		if s[1] <> 'z' then
			writeln(s);
	end;

	close(f);
	readln();
End.
