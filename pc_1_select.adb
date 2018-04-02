with text_io;
use text_io;

procedure pc_1_sp is
	task type consumer;
	task type producer;
	task type buffer is 
		entry insert(item : in Integer);
		entry remove;
	end buffer;

	b : buffer;
	c : consumer;
	p : producer;

	task body buffer is 
		buf : integer := 0;
		empty : boolean := true;
	begin
		loop
			select
				when empty=true =>
					accept insert(item : in integer) do
						buf := item;
						empty := false;
						put_line("inserted: " & buf'img);
						delay 0.5;
					end;
			or
				when empty=false => 
					accept remove do
						empty := true;
						put_line("removed: " & buf'img);
						delay 0.5;
					end;
			end select;
		end loop;
	end buffer;
	
	task body consumer is
	begin
		loop
			b.remove;
		end loop;
	end consumer;

	task body producer is
		item : Integer := 0;
	begin
		loop
			item := item + 1;
			b.insert(item);
		end loop;
	end producer;

begin
	null;
end pc_1_sp;
