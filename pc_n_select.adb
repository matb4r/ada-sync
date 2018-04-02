with text_io;
use text_io;

procedure pc_n_sp is 

task type consumer;
task type producer;
task type buffer is
	entry insert(item : in integer);
	entry remove(item : out integer);
end buffer;

	b : buffer;
	c : consumer;
	p : producer;

task body buffer is
	buf : array (0..4) of integer;
	i : integer := 0;
begin
	loop
		select
			when i < 5 => accept insert(item : in integer) do
				buf(i) := item;
				put_line("inserted at" & i'img & " -" & buf(i)'img);
				i := i + 1;
				delay 0.5;
			end;
		or
			when i > 0 => accept remove(item : out integer) do
				i := i - 1;
				item := buf(i);
				put_line("removed from " & i'img & " - " & buf(i)'img);
				delay 0.5;
			end;
		end select;
	end loop;
end buffer;

task body consumer is 
	item_out : integer;
begin
	loop
		b.remove(item_out);
		delay 2.0;
	end loop;
end consumer;

task body producer is
	item : integer := 0;
begin
	loop
		b.insert(item);
		item := item + 1;
	end loop;
end producer;

begin
	null;
end pc_n_sp;
