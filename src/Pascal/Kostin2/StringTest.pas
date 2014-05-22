var
	s1: string [20];
	s2: string [20];

begin
	s1 := 'hello';
	s2 := 'halo';
	writeln('>', s1, '<');
	writeln(s1[2]);
	writeln(s2 < s1);
	Insert('e', s2, 3);
	writeln(s2);
end.
