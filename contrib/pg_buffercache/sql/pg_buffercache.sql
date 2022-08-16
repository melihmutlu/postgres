CREATE EXTENSION pg_buffercache;

select count(*) = (select setting::bigint
                   from pg_settings
                   where name = 'shared_buffers')
from pg_buffercache;

select used_buffers + unused_buffers > 0,
        dirty_buffers < used_buffers,
        pinned_buffers < used_buffers
from pg_buffercache_summary();