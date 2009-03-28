CREATE TABLE modules (
    module      VARCHAR(256),
    modversion  VARCHAR(24),
    dist        VARCHAR(256),
    distversion VARCHAR(24)
);
CREATE UNIQUE INDEX modules_idx ON modules(module, modversion, dist, distversion);
CREATE TABLE dists (
    dist        VARCHAR(256),
    distversion VARCHAR(24),
    file        VARCHAR(256)
);
CREATE UNIQUE INDEX dists_idx ON dists(dist, distversion);
CREATE UNIQUE INDEX files_idx ON dists(file);
CREATE TABLE passes (
    id          INT,
    dist        VARCHAR(256),
    distversion VARCHAR(24),
    perl        VARCHAR(8)
);
CREATE        INDEX perl_idx ON passes(perl);
CREATE UNIQUE INDEX passid_idx ON passes(id);
