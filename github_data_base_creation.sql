SET XACT_ABORT ON

BEGIN TRANSACTION SAADBD

CREATE TABLE Repositories (
    name varchar(500)  NOT NULL ,
    -- Clustered
    url varchar(555)  NOT NULL ,
    description varchar(600)  NOT NULL ,
    stars int  NOT NULL ,
    created_at date  NOT NULL ,
    language varchar(500)  NOT NULL ,
    forks int  NOT NULL ,
    watchers int  NOT NULL ,
    open_issues int  NOT NULL ,
    owner_id int  NOT NULL ,
    contributors_count int  NOT NULL ,
    CONSTRAINT PK_Repositories PRIMARY KEY CLUSTERED (
        url ASC
    )
)

CREATE TABLE Commits (
    repos_url varchar(555)  NOT NULL ,
    -- Clustered
    id int  NOT NULL ,
    author_name varchar(500)  NOT NULL ,
    author_date date  NOT NULL ,
    committer_name varchar(500)  NOT NULL ,
    committer_date date  NOT NULL ,
    CONSTRAINT PK_Commits PRIMARY KEY CLUSTERED (
        id ASC
    )
)

CREATE TABLE Contributors (
    -- Clustered
    id int  NOT NULL ,
    name varchar(500)  NOT NULL ,
    profile_url varchar(555)  NOT NULL ,
    CONSTRAINT PK_Contributors PRIMARY KEY CLUSTERED (
        id ASC
    )
)

CREATE TABLE Contributions (
    repo_url varchar(555)  NOT NULL ,
    contributor_id int  NOT NULL ,
    count int  NOT NULL 
)

CREATE TABLE Languages (
    -- Clustered
    id int  NOT NULL ,
    name varchar(500)  NOT NULL ,
    CONSTRAINT PK_Languages PRIMARY KEY CLUSTERED (
        id ASC
    )
)

CREATE TABLE Language_usage (
    repo_url varchar(555)  NOT NULL ,
    language_id int  NOT NULL ,
    bytes_of_code int  NOT NULL 
)

CREATE TABLE Owner (
    id int  NOT NULL ,
    name varchar(500)  NOT NULL ,
    profile_url varchar(555)  NOT NULL 
    CONSTRAINT PK_Owner PRIMARY KEY CLUSTERED (
        id ASC
    )
)

ALTER TABLE Repositories WITH CHECK ADD CONSTRAINT FK_Repositories_owner_id FOREIGN KEY(owner_id)
REFERENCES Owner (id)

ALTER TABLE Repositories CHECK CONSTRAINT FK_Repositories_owner_id

ALTER TABLE Commits WITH CHECK ADD CONSTRAINT FK_Commits_repos_url FOREIGN KEY(repos_url)
REFERENCES Repositories (url)

ALTER TABLE Commits CHECK CONSTRAINT FK_Commits_repos_url

ALTER TABLE Contributions WITH CHECK ADD CONSTRAINT FK_Contributions_repo_url FOREIGN KEY(repo_url)
REFERENCES Repositories (url)

ALTER TABLE Contributions CHECK CONSTRAINT FK_Contributions_repo_url

ALTER TABLE Contributions WITH CHECK ADD CONSTRAINT FK_Contributions_contributor_id FOREIGN KEY(contributor_id)
REFERENCES Contributors (id)

ALTER TABLE Contributions CHECK CONSTRAINT FK_Contributions_contributor_id

ALTER TABLE Language_usage WITH CHECK ADD CONSTRAINT FK_Language_usage_repo_url FOREIGN KEY(repo_url)
REFERENCES Repositories (url)

ALTER TABLE Language_usage CHECK CONSTRAINT FK_Language_usage_repo_url

ALTER TABLE Language_usage WITH CHECK ADD CONSTRAINT FK_Language_usage_language_id FOREIGN KEY(language_id)
REFERENCES Languages (id)

ALTER TABLE Language_usage CHECK CONSTRAINT FK_Language_usage_language_id

COMMIT TRANSACTION SAADBD