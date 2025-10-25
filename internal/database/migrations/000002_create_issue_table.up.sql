create table if not exists issue (
    id uuid primary key,
    title text not null,
    description text not null,
    image_url text,
    link_id uuid references link(id) on delete set null,
    created_at timestamp with time zone default current_timestamp not null,
    updated_at timestamp with time zone default current_timestamp,
    deleted_at timestamp with time zone
);
