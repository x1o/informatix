program PrintFamilyNameNotSh;

var
	i, n: integer;
	f: file of string;
	{ f: text; }
	s: string;

begin
	assign(f, 'Family_names.txt');
	reset(f);
	while not(eof(f)) do 
	begin
		read(f, s); 
		{ write('* (', s[1], ') '); }
		{ writeln(Length(s)); }
		{ if s[1] <> 'Ø' then }
		if s[1] <> 'z' then
			writeln(s)
	end;

	close(f); 
End.
