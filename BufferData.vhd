entity BufferData is
    Port (
        DataIn  : in  STD_LOGIC_VECTOR(3 downto 0); -- Datos externos
        DataBus : inout STD_LOGIC_VECTOR(3 downto 0); -- Bus compartido
        OE      : in  STD_LOGIC                      -- Habilitación (Extern)
    );
end BufferData;

architecture Behavioral of BufferData is
begin
    -- Control de salida del buffer
    process(DataIn, OE)
    begin
        if OE = '1' then
            DataBus <= DataIn; -- Habilitar datos externos en el bus
        else
            DataBus <= (others => 'Z'); -- Alta impedancia cuando no está habilitado
        end if;
    end process;
end Behavioral;
