# Instructions

XXX: TODO: Use perlbrew and not system perl...

Install DBIx::Class

```
sudo cpanm DBIx::Class
```

Install DBIx::Class::Schema::Loader
```
sudo cpanm DBIx::Class::Schema::Loader
```

Dump Schema
```
sudo dbicdump -o dump_directory=./lib -o components='["InflateColumn::DateTime"]' Barabend::Model::Schema dbi:mysql:database=barabend
```

