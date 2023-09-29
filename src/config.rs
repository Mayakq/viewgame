#[derive(Debug, Clone)]
pub struct Config {
    pub db: Database,
    pub jwt_settings: JWT,
    pub server: Server,
}

#[derive(Debug, Clone)]
pub struct Database {
    pub url: String,
}

#[derive(Debug, Clone)]
pub struct JWT {
    pub jwt_secret: String,
    pub jwt_expires_in: String,
    pub jwt_max_age: u8,
}

#[derive(Debug, Clone)]
pub struct Server {
    pub port: String,
}

impl Config {
    pub fn init() -> Config {
        let database_url = std::env::var("DATABASE_URL").expect("DATABASE_URL must be set");
        let jwt_secret = std::env::var("JWT_SECRET").expect("JWT_SECRET must be set");
        let jwt_expires_in = std::env::var("JWT_EXPIRED_IN").expect("JWT_EXPIRED_IN must be set");
        let jwt_max_age = std::env::var("JWT_MAXAGE").expect("JWT_MAXAGE must be set");
        let port = std::env::var("PORT").expect("IP has not been set");
        Config {
            db: Database { url: database_url },
            jwt_settings: JWT {
                jwt_secret,
                jwt_expires_in,
                jwt_max_age: jwt_max_age.parse::<u8>().expect("Expected u8."),
            },
            server: Server {
                port,
            },
        }
    }
}