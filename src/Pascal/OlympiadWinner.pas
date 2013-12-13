program OlympiadWinner;

uses
	Strings,
	Matrix2D,
	crt,
	sysutils;

var
	i, n, max_score, cur_score, best_candidate, same_score_n: integer;
	input_file: textfile;
	output_file: textfile;
	input_str: string;
	participant: TStringDynArray;
	{ FamilyName GivenName Grade Score }
	P: array of TStringDynArray;
	candidates, winners: array of integer;
	winners_s: set of byte;


begin
	clrscr();
	assign(input_file, 'olympiad_results_4.txt');
	reset(input_file);
	assign(output_file, 'olympiad_results_processed.txt');
	rewrite(output_file);
	
	readln(input_file, input_str);
	n := StrToInt(input_str);
	
	SetLength(P, n);
	SetLength(candidates, 0);
	SetLength(winners, 0);
	max_score := -1;
	
	for i:=0 to n-1 do
	begin
		readln(input_file, input_str);
		participant := Split(input_str, ' ');
		P[i] := participant;
	end;
	
	close(input_file);
	
	for i:=0 to n-1 do
	begin
		cur_score := StrToInt(P[i][3]);
		if cur_score < max_score then
			continue;
		if cur_score = max_score then
		begin
			SetLength(candidates, Length(candidates)+1);
			candidates[Length(candidates)-1] := i;
		end
		else
			begin
				max_score := cur_score;
				SetLength(candidates, 1);
				candidates[0] := i;
			end;
	end;

	writeln('Max score: ', max_score);
	writeln('Candidates:');
	for i:=0 to Length(candidates)-1 do
	begin
		PrintArray(P[candidates[i]], ' ');
		writeln();
	end;

	if (Length(candidates) / n) <= 0.25 then
		winners := candidates
	else
		if max_score > 300 then
				winners := candidates;

	writeln('Winners:');
	for i:=0 to Length(winners)-1 do
	begin
		PrintArray(P[winners[i]], ' ');
		writeln();
		Include(winners_s, winners[i]);
	end;

	{
	if Length(winners) = 0 then
	begin
		writeln('No winners');
		writeln('Number of participants: ', n);
		write(output_file, n);
		close(output_file);
		exit;
	end;
	}
	
	same_score_n := 0;
	max_score := -1;
	for i:=0 to Length(P)-1 do
		if not (i in winners_s) then
		begin
			cur_score := StrToInt(P[i][3]);
			if cur_score = max_score then
			begin
				same_score_n := same_score_n + 1;
				writeln('Same score ', cur_score);
			end;
			if cur_score > max_score then
			begin
				best_candidate := i;
				max_score := cur_score;
			end;
		end;
	
	if same_score_n <> 0 then
	begin
		writeln(same_score_n + 1, ' people with the same score');
		write(output_file, same_score_n + 1);
	end
	else
		begin
			write('Best non-winner: ');
			write(P[best_candidate][0], ' ', P[best_candidate][1]);
			write(output_file, P[best_candidate][0], ' ', P[best_candidate][1]);
		end;

close(output_file);
end.