library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


entity pmw is 
port (
  clk	: in std_logic; -- 50 MHz
  sens: in std_logic; -- switche pour controler le sens du rotation
  SW	: in std_logic_vector(1 downto 0); -- deux switches pour controler la vitesse de rotation
  GPIO_1: out std_logic_vector(3 downto 0)  -- outputs pour alimenter les bobines
);
end pmw;

architecture arc of pmw is

  signal count	: integer := 0;

begin

pwm_speed_gen : process(SW) 

begin

  if (SW = "00") then -- la vitesse la plus lente
  	count	<= 2_880_000;     
  elsif (SW = "01") then -- Vitesse 2
  	count	<= 1_440_000;
  elsif (SW = "10") then -- Vitesse 3
  	count	<= 720_000;
  elsif (SW = "11") then -- la vitesse la plus rapide
  	count	<= 360_000;
  end if;

end process;

pwm_gen	: process(clk)

variable cntr : integer := 0;

begin

if (clk'event and clk = '1') then
  	if sens = '0' then
  	cntr	:= cntr + 1; 
  	    
  	    if (cntr < count*1/8) then
  		GPIO_1	<= "0001";
  		elsif (cntr < count*2/8) then
  		GPIO_1	<= "0011";
  		elsif (cntr < count*3/8) then
  		GPIO_1	<= "0010";
  	    elsif (cntr < count*4/8) then
  		GPIO_1	<= "0110";
  		elsif (cntr < count*5/8) then
  		GPIO_1	<= "0100";
  	    elsif (cntr < count*6/8) then
  		GPIO_1	<= "1100";
  		elsif (cntr < count*7/8) then
  		GPIO_1	<= "1000";
  	    elsif (cntr < count*8/8) then
  		GPIO_1	<= "1001";
  	    else
  		cntr	:= 0;
  	    end if;
  	        
    else
    cntr	:= cntr + 1;
    
    if (cntr < count*1/8) then
  		GPIO_1	<= "1000";
  		elsif (cntr < count*2/8) then
  		GPIO_1	<= "1100";
  		elsif (cntr < count*3/8) then
  		GPIO_1	<= "0100";
  	    elsif (cntr < count*4/8) then
  		GPIO_1	<= "0110";
  		elsif (cntr < count*5/8) then
  		GPIO_1	<= "0010";
  	    elsif (cntr < count*6/8) then
  		GPIO_1	<= "0011";
  		elsif (cntr < count*7/8) then
  		GPIO_1	<= "0001";
  	    elsif (cntr < count*8/8) then
  		GPIO_1	<= "1001";
  	    else
  		cntr	:= 0;
  	    end if;
                 
    end if;
end if;
end process;
	
end arc;
