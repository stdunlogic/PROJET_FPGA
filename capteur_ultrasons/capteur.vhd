-- Source - https://stackoverflow.com/q/27580741
-- Posted by Berk Erbas, modified by community. See post 'Timeline' for change history
-- Retrieved 2026-02-19, License - CC BY-SA 3.0
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity capteur is
port (clk   : in  std_logic;      -- 50 MHz
        echo  : in  std_logic;
        trig  : out std_logic;
        dizaine_out : out std_logic_vector (3 downto 0);
        unite_out : out std_logic_vector (3 downto 0)
    );
end capteur;

architecture arc of capteur is
  signal distance : integer := 0;
  signal dizaine  : integer := 0;
  signal unite    : integer := 0;
begin
process(clk)
 variable c1,c2: integer:=0;
 variable y :std_logic:='1';
begin
    if (clk'event and clk='1') then

        if(c1=0) then -- mettre trig à 1 pendant 10us
            trig<='1';
        elsif(c1=500) then -- 10us
            trig<='0';
            y:='1';
        elsif(c1=50000000) then -- remettre trig à 1 chaque seconde
            c1:=0;
            trig<='1';
        end if;
        c1:=c1+1;

        if(echo = '1') then
            c2:=c2+1;
        elsif(echo = '0' and y='1' ) then
        distance <= c2/2900;
            if distance > 99 then -- on limite la distance à 99cm pour éviter d'avoir 
            -- A,B .. F dans l'afficheur
            distance <= 99;
            end if;
            dizaine  <= (c2/2900)/10; -- pour pouvoir afficher la mesure sur les afficheurs
            unite <= (c2/2900) mod 10;
            c2:=0;
            y:='0';
        end if;
    end if; 
end process ;
dizaine_out <= std_logic_vector(to_unsigned(dizaine,4)); -- convertir la mesure pour la mettre en entrée du symbole affichage
unite_out   <= std_logic_vector(to_unsigned(unite,4));
end arc;
