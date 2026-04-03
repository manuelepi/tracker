-- Enable Row Level Security
ALTER TABLE tracker ENABLE ROW LEVEL SECURITY;
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_settings ENABLE ROW LEVEL SECURITY;

-- Create tracker table
CREATE TABLE tracker (
    id SERIAL PRIMARY KEY,
    user_id UUID REFERENCES auth.users ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    category_id INTEGER REFERENCES categories(id) ON DELETE SET NULL,
    created_at TIMESTAMP DEFAULT current_timestamp,
    updated_at TIMESTAMP DEFAULT current_timestamp,
    is_complete BOOLEAN DEFAULT FALSE
);

-- Create categories table
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    user_id UUID REFERENCES auth.users ON DELETE CASCADE,
    name VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT current_timestamp
);

-- Create user_settings table
CREATE TABLE user_settings (
    id SERIAL PRIMARY KEY,
    user_id UUID REFERENCES auth.users ON DELETE CASCADE,
    setting_key VARCHAR(100) UNIQUE NOT NULL,
    setting_value VARCHAR(255),
    created_at TIMESTAMP DEFAULT current_timestamp,
    updated_at TIMESTAMP DEFAULT current_timestamp
);

-- RLS Policy for tracker table
CREATE POLICY select_tracker ON tracker
FOR SELECT
USING (user_id = auth.uid());

CREATE POLICY insert_tracker ON tracker
FOR INSERT
WITH CHECK (user_id = auth.uid());

CREATE POLICY update_tracker ON tracker
FOR UPDATE
USING (user_id = auth.uid());

CREATE POLICY delete_tracker ON tracker
FOR DELETE
USING (user_id = auth.uid());

-- RLS Policy for categories table
CREATE POLICY select_categories ON categories
FOR SELECT
USING (user_id = auth.uid());

CREATE POLICY insert_categories ON categories
FOR INSERT
WITH CHECK (user_id = auth.uid());

CREATE POLICY update_categories ON categories
FOR UPDATE
USING (user_id = auth.uid());

CREATE POLICY delete_categories ON categories
FOR DELETE
USING (user_id = auth.uid());

-- RLS Policy for user_settings table
CREATE POLICY select_user_settings ON user_settings
FOR SELECT
USING (user_id = auth.uid());

CREATE POLICY insert_user_settings ON user_settings
FOR INSERT
WITH CHECK (user_id = auth.uid());

CREATE POLICY update_user_settings ON user_settings
FOR UPDATE
USING (user_id = auth.uid());

CREATE POLICY delete_user_settings ON user_settings
FOR DELETE
USING (user_id = auth.uid());