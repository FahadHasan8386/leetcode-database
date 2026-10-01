-- =========================================
-- USERS
-- =========================================

CREATE TABLE users (
    id UUID NOT NULL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE
);


-- Insert user
INSERT INTO users (id, name, email)
VALUES (
    gen_random_uuid(),
    'Fahad',
    'fahad@gmail.com'
);


-- =========================================
-- TWEETS
-- =========================================

CREATE TABLE tweets (
    id UUID NOT NULL PRIMARY KEY,
    content TEXT NOT NULL,
    user_id UUID NOT NULL,

    FOREIGN KEY (user_id)
        REFERENCES users(id)
);


-- =========================================
-- LIKES
-- =========================================

CREATE TABLE likes (
    id UUID NOT NULL PRIMARY KEY,
    user_id UUID NOT NULL,
    tweet_id UUID NOT NULL,

    FOREIGN KEY (user_id)
        REFERENCES users(id),

    FOREIGN KEY (tweet_id)
        REFERENCES tweets(id),

    UNIQUE (user_id, tweet_id)
);


-- =========================================
-- FOLLOWS
-- =========================================

CREATE TABLE follows (
    id UUID NOT NULL PRIMARY KEY,
    follower_id UUID NOT NULL,
    following_id UUID NOT NULL,

    FOREIGN KEY (follower_id)
        REFERENCES users(id),

    FOREIGN KEY (following_id)
        REFERENCES users(id),

    UNIQUE (follower_id, following_id),

    CHECK (follower_id <> following_id)
);


-- =========================================
-- BOOKMARKS
-- =========================================

CREATE TABLE bookmarks (
    id UUID NOT NULL PRIMARY KEY,
    user_id UUID NOT NULL,
    tweet_id UUID NOT NULL,

    FOREIGN KEY (user_id)
        REFERENCES users(id),

    FOREIGN KEY (tweet_id)
        REFERENCES tweets(id),

    UNIQUE (user_id, tweet_id)
);


-- =========================================
-- RETWEETS
-- =========================================

CREATE TABLE retweets (
    id UUID NOT NULL PRIMARY KEY,
    user_id UUID NOT NULL,
    tweet_id UUID NOT NULL,
    comment TEXT,

    FOREIGN KEY (user_id)
        REFERENCES users(id),

    FOREIGN KEY (tweet_id)
        REFERENCES tweets(id),

    UNIQUE (user_id, tweet_id)
);


-- =========================================
-- MESSAGES
-- =========================================

CREATE TABLE messages (
    id UUID NOT NULL PRIMARY KEY,
    sender_id UUID NOT NULL,
    receiver_id UUID NOT NULL,
    content TEXT NOT NULL,
    sent_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    is_read BOOLEAN NOT NULL DEFAULT FALSE,

    FOREIGN KEY (sender_id)
        REFERENCES users(id),

    FOREIGN KEY (receiver_id)
        REFERENCES users(id)
);


-- =========================================
-- NOTIFICATIONS
-- =========================================

CREATE TABLE notifications (
    id UUID NOT NULL PRIMARY KEY,
    user_id UUID NOT NULL,
    sender_id UUID,
    notification_type TEXT NOT NULL,
    message TEXT NOT NULL,
    is_read BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    FOREIGN KEY (user_id)
        REFERENCES users(id),

    FOREIGN KEY (sender_id)
        REFERENCES users(id)
);



