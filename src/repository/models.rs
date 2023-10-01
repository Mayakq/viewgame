use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};
use sqlx::FromRow;
use uuid::Uuid;

#[derive(Debug, Deserialize, Serialize, FromRow, Clone)]
#[allow(non_camel_case_types)]
pub struct users {
    id: Uuid,
    name: String,
    email: String,
    email_confirmed: bool,
    hash_password: String,
    blocking_reason: Option<String>,
    date_add: DateTime<Utc>,
    date_update: DateTime<Utc>,
    date_ban: Option<DateTime<Utc>>,
}

#[derive(Debug, Deserialize, Serialize, FromRow, Clone)]
#[allow(non_camel_case_types)]
pub struct roles {
    id: Uuid,
    name: String,
    date_update: DateTime<Utc>,
    date_add: DateTime<Utc>,
}


#[derive(Debug, Deserialize, Serialize, FromRow, Clone)]
#[allow(non_camel_case_types)]
pub struct user_roles {
    id_role: Uuid,
    id_user: String,
    date_update: DateTime<Utc>,
    date_add: DateTime<Utc>,
}

#[derive(Debug, Deserialize, Serialize, FromRow, Clone)]
#[allow(non_camel_case_types)]
pub struct games {
    id: Uuid,
    release: bool,
    test: bool,
    name: Option<String>,
    date_release: DateTime<Utc>,
    date_update: DateTime<Utc>,
    date_add: Option<DateTime<Utc>>,
}

#[derive(Debug, Deserialize, Serialize, FromRow, Clone)]
#[allow(non_camel_case_types)]
pub struct section {
    id: Uuid,
    id_game: Uuid,
    name: String,
    is_open: bool,
    date_add: Option<DateTime<Utc>>,
    date_update: DateTime<Utc>,
}
#[derive(Debug, Deserialize, Serialize, FromRow, Clone)]
#[allow(non_camel_case_types)]
pub struct posts {
    id: Uuid,
    id_author: Uuid,
    id_section: Uuid,
    title: String,
    text: String,
    is_open: bool,
    reason_delete: Option<String>,
    date_add: DateTime<Utc>,
    date_update: DateTime<Utc>,
    date_delete: DateTime<Utc>
}

#[derive(Debug, Deserialize, Serialize, FromRow, Clone)]
#[allow(non_camel_case_types)]
pub struct messages {
    id: Uuid,
    id_parent: Uuid,
    id_user: Uuid,
    id_post: Uuid,
    text: String,
    reason_delete: Option<String>,
    date_add: DateTime<Utc>,
    date_update: DateTime<Utc>,
    date_delete: DateTime<Utc>
}

#[derive(Debug, Deserialize, Serialize, FromRow, Clone)]
#[allow(non_camel_case_types)]
pub struct files {
    id: Uuid,
    id_message: Uuid,
    date_delete: String
}