create table if not exists link (
    id uuid primary key,
    url text not null unique,
    created_by varchar(255) not null,
    updated_at timestamp with time zone default current_timestamp not null,
    created_at timestamp with time zone default current_timestamp,
    deleted_at timestamp with time zone
);
