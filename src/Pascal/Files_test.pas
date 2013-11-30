program PrintFamilyNameNotSh;

var
	i, n: integer;
	f: file of string;
	{ f: text; }
	s: string;

begin
	assign(f, 'Family_names.lst');
	rewrite(f);

	write('Введите количество учащихся: ');
	readln(n);

	for i:=1 to n do
	begin
		writeln('Введите фамилию:');
		readln(s);
		write(f, s);
		{ write(f, #10); }
	end;

	close(f); 
	reset(f); 

	writeln;
	writeln('Список учащихся:');

	while not(eof(f)) do 
	begin 
		read(f, s); 
		write('* (', s[1], ') ');
		writeln(Length(s));
		{ if s[1] <> 'Ш' then  }
		if s[1] <> 'Z' then 
			writeln(s)
	end;

	close(f); 
End.
