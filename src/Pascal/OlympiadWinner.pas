program OlympiadWinner;

uses
	crt,
	sysutils;

const
	input_fname =  '../../data/olympiad_results_4.txt';
	output_fname =  '../../data/olympiad_results_processed.txt';

type
	participant = record 
		family_name:	string[20];
		given_name:	string[15];
		grade:		integer;
		score:		integer;
	end;

var
	i, n, max_score, cur_score, best_candidate, same_score_n: integer;
	input_file, output_file: textfile;
	input_str: string;
	P: array of participant;
	candidates, winners: array of integer;
	winners_s: set of byte;

procedure PrintPartic(p: participant);
begin
	writeln(p.family_name, ' ', p.given_name, ' ', p.grade, ' ', p.score);
end;

function Split(S: string): participant;
var
	Res: participant;
	i, j, cnt: integer;
	token: string;
begin
	cnt := 0;
	j := 1;
	for i := 1 to Length(S) do
		if (S[i] = ' ') then
		begin
			token := Copy(S, j, i-j);
			case cnt of
				0: Res.family_name := token;
				1: Res.given_name := token;
				2: Res.grade := StrToInt(token);
			end;
			j := i+1;
			Inc(cnt);
		end;
	Res.score := StrToInt(Copy(S, j, i-j+1)); { at the end of the string }
	Split := Res;
end;

begin
	clrscr();
	assign(input_file, input_fname);
	reset(input_file);
	assign(output_file, output_fname);
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
		P[i] := Split(input_str);
	end;

	close(input_file);

	for i:=0 to n-1 do
	begin
		cur_score := P[i].score;
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
		PrintPartic(P[candidates[i]]);
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
		PrintPartic(P[winners[i]]);
		writeln();
		Include(winners_s, winners[i]);
	end;

	same_score_n := 0;
	max_score := -1;
	for i:=0 to Length(P)-1 do
		if not (i in winners_s) then
		begin
			cur_score := P[i].score;
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
		writeln(output_file, same_score_n + 1);
	end
	else
		begin
			write('Best non-winner: ');
			writeln(output_file, P[best_candidate].family_name, ' ', P[best_candidate].given_name);
			writeln(P[best_candidate].family_name, ' ', P[best_candidate].given_name);
		end;

	close(output_file);
end.
