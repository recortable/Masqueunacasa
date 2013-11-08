class CreateCatalanDictionary < ActiveRecord::Migration
  def up
    execute "
      CREATE TEXT SEARCH DICTIONARY catalan (
        TEMPLATE = ispell,
        DictFile = ca_es,
        AffFile = ca_es
      );"

    execute "
      CREATE TEXT SEARCH CONFIGURATION public.catalan ( COPY = pg_catalog.spanish );
      ALTER TEXT SEARCH CONFIGURATION catalan
        ALTER MAPPING FOR asciiword, asciihword, hword_asciipart, word, hword, hword_part
        WITH catalan, simple;
    "
  end

  def down
    execute "DROP TEXT SEARCH DICTIONARY catalan;"
    execute "DROP TEXT SEARCH CONFIGURATION catalan;"
  end
end

