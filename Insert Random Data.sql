-- Insert random data into `public.contact_type`
INSERT INTO public.contact_type (contact_type_title)
SELECT 'Type ' || generate_series
FROM generate_series(1, 5); -- Generate 5 records

-- Insert random data into `public.necessities`
INSERT INTO public.necessities (necessity_title)
SELECT 'Necessity ' || generate_series
FROM generate_series(1, 5); -- Generate 5 records

-- Insert random data into `public.disease`
INSERT INTO public.disease (disease_title)
SELECT 'Disease ' || generate_series
FROM generate_series(1, 5); -- Generate 5 records

-- Insert random data into `public.organization_sector`
INSERT INTO public.organization_sector (organization_sector_title)
SELECT 'Sector ' || generate_series
FROM generate_series(1, 5); -- Generate 5 records

-- Insert random data into `public.person`
INSERT INTO public.person (first_name, last_name, email, homeless_reason)
SELECT
  chr(trunc(65 + random()*26)::int) || chr(trunc(65 + random()*26)::int), -- Random two-letter first name
  chr(trunc(65 + random()*26)::int) || chr(trunc(65 + random()*26)::int), -- Random two-letter last name
  'user' || generate_series || '@example.com', -- Sequential email addresses
  'Reason ' || generate_series -- A simple reason text with a number
FROM generate_series(1, 10); -- Generate 10 records

-- Insert random data into `public.organization`
INSERT INTO public.organization (organization_title, organization_sector_id)
SELECT
  'Organization ' || generate_series, -- Organization names with sequential numbers
  generate_series % 5 + 1 -- Random sector_id between 1 and 5
FROM generate_series(1, 10); -- Generate 10 records

-- Insert random data into `public.person_necessities`
-- This assumes that person_id and necessity_id are already populated.
INSERT INTO public.person_necessities (person_id, necessity_id)
SELECT
  (SELECT person_id FROM public.person ORDER BY random() LIMIT 1), -- Random person_id
  (SELECT necessity_id FROM public.necessities ORDER BY random() LIMIT 1) -- Random necessity_id
FROM generate_series(1, 10); -- Generate 10 records

-- Insert random data into `public.person_health`
-- This assumes that person_id and disease_id are already populated.
INSERT INTO public.person_health (person_id, disease_id)
SELECT
  (SELECT person_id FROM public.person ORDER BY random() LIMIT 1), -- Random person_id
  (SELECT disease_id FROM public.disease ORDER BY random() LIMIT 1) -- Random disease_id
FROM generate_series(1, 10); -- Generate 10 records

-- Insert random data into `public.person_location`
-- This assumes that person_id is already populated.
INSERT INTO public.person_location (person_id, lat, long)
SELECT
  (SELECT person_id FROM public.person ORDER BY random() LIMIT 1), -- Random person_id
  40 + random()*(20), -- Random latitude between 40 and 60
  -80 + random()*(40) -- Random longitude between -80 and -40
FROM generate_series(1, 10); -- Generate 10 records

-- Insert random data into `public.phone_contact`
-- This assumes that person_id and contact_type_id are already populated.
INSERT INTO public.phone_contact (person_id, contact_type_id, contact, description)
SELECT
  (SELECT person_id FROM public.person ORDER BY random() LIMIT 1), -- Random person_id
  (SELECT contact_type_id FROM public.contact_type ORDER BY random() LIMIT 1), -- Random contact_type_id
  '555-01' || lpad(generate_series::text, 2, '0'), -- Phone number with sequence
  'Contact for ' || chr(trunc(65 + random()*26)::int) -- Random contact description
FROM generate_series(1, 10); -- Generate 10 records
