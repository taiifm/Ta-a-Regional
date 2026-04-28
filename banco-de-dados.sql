-- ================================================
-- EXECUTE ISSO NO SUPABASE SQL EDITOR
-- Dashboard > SQL Editor > New query > Cole e execute
-- ================================================

-- Tabela de times
CREATE TABLE times (
  id SERIAL PRIMARY KEY,
  nome TEXT NOT NULL,
  grupo TEXT NOT NULL
);

-- Inserir os 6 times (você pode renomear depois no painel admin)
INSERT INTO times (nome, grupo) VALUES
  ('Time A1', 'A'),
  ('Time A2', 'A'),
  ('Time A3', 'A'),
  ('Time B1', 'B'),
  ('Time B2', 'B'),
  ('Time B3', 'B');

-- Tabela de jogos
CREATE TABLE jogos (
  id SERIAL PRIMARY KEY,
  esporte TEXT NOT NULL,
  time_a TEXT NOT NULL,
  time_b TEXT NOT NULL,
  gols_a INTEGER DEFAULT 0,
  gols_b INTEGER DEFAULT 0,
  data DATE,
  hora TIME,
  grupo TEXT,
  fase TEXT DEFAULT 'grupos',
  rodada TEXT,
  status TEXT DEFAULT 'agendado'
);

-- Habilitar atualizações em tempo real (Realtime)
ALTER TABLE jogos REPLICA IDENTITY FULL;
ALTER TABLE times REPLICA IDENTITY FULL;

-- Permissões públicas de leitura (site da torcida)
CREATE POLICY "leitura_publica_jogos" ON jogos FOR SELECT USING (true);
CREATE POLICY "leitura_publica_times" ON times FOR SELECT USING (true);

-- Permissões de escrita (o admin.html usa a mesma anon key, mas em produção
-- você pode restringir isso com Row Level Security)
CREATE POLICY "escrita_jogos" ON jogos FOR ALL USING (true);
CREATE POLICY "escrita_times" ON times FOR ALL USING (true);

-- Ativar RLS nas tabelas
ALTER TABLE jogos ENABLE ROW LEVEL SECURITY;
ALTER TABLE times ENABLE ROW LEVEL SECURITY;
