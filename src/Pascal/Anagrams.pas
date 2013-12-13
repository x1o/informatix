{ 12.20 }
program Anagrams;

uses Strings;

var
	Words: TStringDynArray;
	Matched_ids: set of byte;
	i, j, l: integer;
	f: textfile;
	cur_word: string;

begin
	SetLength(Words, 0);

	assign(f, 'anagrams_dict.txt');
	reset(f);
	while not(eof(f)) do
	begin
		readln(f, cur_word);
		l := Length(Words);
		SetLength(Words, l+1);
		Words[l] := cur_word;
	end;
	close(f);

	for i := 0 to length(Words)-1 do
		writeln(i, ': ', Words[i]);

	for i := 0 to Length(Words)-1 do
	begin
		if i in Matched_ids then
			continue;
		for j := i+1 to Length(Words)-1 do
		begin
			if j in Matched_ids then
				continue;
			if lowercase(Words[i]) = Reversed(lowercase(Words[j])) then
			begin
				writeln(Words[i], ' ~ ', Words[j]);
				Include(Matched_ids, j);
			end;
		end;
	end;
end.
