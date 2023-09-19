CREATE TABLE vss_db
(
    store_id TEXT NOT NULL CHECK (store_id != ''),
    key TEXT NOT NULL,
    value TEXT,
    version BIGINT NOT NULL,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (store_id, key)
);

-- triggers to set dates automatically, generated by ChatGPT

-- Function to set created_date and updated_date during INSERT
CREATE OR REPLACE FUNCTION set_created_date()
RETURNS TRIGGER AS $$
BEGIN
   NEW.created_date := CURRENT_TIMESTAMP;
   NEW.updated_date := CURRENT_TIMESTAMP;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Function to set updated_date during UPDATE
CREATE OR REPLACE FUNCTION set_updated_date()
RETURNS TRIGGER AS $$
BEGIN
   NEW.updated_date := CURRENT_TIMESTAMP;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for INSERT operation on vss_db
CREATE TRIGGER tr_set_dates_after_insert
    BEFORE INSERT ON vss_db
    FOR EACH ROW
    EXECUTE FUNCTION set_created_date();

-- Trigger for UPDATE operation on vss_db
CREATE TRIGGER tr_set_dates_after_update
    BEFORE UPDATE ON vss_db
    FOR EACH ROW
    EXECUTE FUNCTION set_updated_date();