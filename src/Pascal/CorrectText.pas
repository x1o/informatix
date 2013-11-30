{ 12.5 }
program CorrectText;

var
	s: string;
	f: file of string;
	{ f: text; }

begin
	assign(f, 'text_for_correction.txt');
	reset(f);

	while not eof(f) do 
	begin 
		read(f, s); 
		writeln('* ', s);
	end;


	close(f);
end.
