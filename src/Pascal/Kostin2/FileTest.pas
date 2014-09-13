type
	IFI = file of integer;
	SF = file of string;
	CF = file of char;

var
	{ f: textfile; }
	{ f: SF; }
	f: RF;
	ch: char;
	s: string;

begin
	assign(f, 'TestData.txt');
	reset(f);
	
	read(f, r);
	{ writeln(r.a); }
	{ writeln(r.b); }
	
	{ text / textfile: }
	{ while not eof(f) do }
	{ begin }
		{ readln(f, s); }
		{ writeln('- ', s); }
	{ end; }
end.
