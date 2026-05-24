-- Migration 050: Add monograph_url to herbal.herbs and populate from BHC Monographs

SET search_path TO herbal, public;

ALTER TABLE herbal.herbs
  ADD COLUMN IF NOT EXISTS monograph_url TEXT;

DO $$
BEGIN
  -- Digestive
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1qw1IOjyRw7i6Ixrd4EYqzF42TnMSaOp9aw07rlkRv-w/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'catnip';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1cMLuyw7Y_7BypYIz7TZx9ZQaMzl0T-wQaeGXK77Hvos/edit?tab=t.0' WHERE common_name ILIKE 'chamomile';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1RQup1u90HLYHEZzCploIbxPxvDSG-fy4c6gAnTagCJs/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'dandelion';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/18EcFGSqs2E-WtEKw3OXbGoGwMMNDa9Msb1mioHD4Fro/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'ginger';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1yczahfNno3lPQ9eQoVxYiy-vcEsmrxkBVyErG5B76yo/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'marshmallow';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1sKdd3iq8e0xg2QzCfwM2ysaMjQ2eIGyt4qJrz3RC3EA/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'mugwort';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/11NLmT9cdT62wQOLuBr_831C9JnbtCfCKfhmNQyUsvso/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'oregon grape root';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1tDDREbCbNjc082ZBu7COIqB8BmPVxrijoEpvjgAl0ls/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'peppermint';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1V0L0JSs9wSwFXkNH-4sMePG2zYjM7tRkCDT1Mj50QaM/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'plantain';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1PuH9Brq8Ry7WVtlCvyU2mX0qVBZnLcd4cBKYMNedXFY/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'valerian';

  -- Immune
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1gQGRItw-oXvEcE6pt-qB1CAWLnCrd4UyDIRan6kCS5o/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'astragalus';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1DCKGxL0nRxE0oHKNxyBWoK3qmLghDbg20Z__r--KHfo/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'echinacea';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1YH0l-iELK7LzCmQhoG1j_faaK2EXtg3dsyOzEQ_NyZg/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'elder';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1Xc_wtWpqXM9WW0ToTVmpYhbbCMqn9nytz6bvJTnhbLs/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'garlic';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1pA3hnhhOUywprp7evXU7RXPK3C7ajELflVib6mBPAjg/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'lomatium';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1drrQ74t5Zt3zoOcM26YnS62zCRatW6M0cHo1Ixef5bE/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'myrrh';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1J6XY7bGox2zH3xY1TBNAiF1hiiqxvPUYyfjBpxB36vU/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'red root';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/16eOvbiMzzkvj6mpUTSS5D-CfvBF3E-szvs6pBm8y6C8/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'reishi';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1n-ssGWbF1nOLvSUpbZeUZNZqvmLu8jmeoF4Ft8JjIkU/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'usnea';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1E5TjtDMVnfHS8KHwcuOrtsnDoVsflG40nzFynMGMD5A/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'yerba mansa';

  -- Respiratory
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1LUsICOSmtMNYRRJ0KHLSk0h6FcULoFWo857kNPFlOxU/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'elecampane';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1Zn7zRdZLuKfab0WMiI2XssPeBXnsEPXgF8a-rfBtJiI/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'goldenrod';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/11zqbgFOB-AfdEj2kIH3R7MgTy6uOD4vliIOexpudstU/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'gumweed';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/16Sk768zfhEdmaz0BcRjMIHPVfHSD1DyG1doCkto5UQ8/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'horehound';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1xcMA1MfCGpGo3kZ-6QF-tQ_afFAJlhUkEsgA_wgPNUs/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'mullein';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1wp7J0Ad9bB7NextaixjiQgvE7t64-NS_AtHMYC73Jfo/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'prince seng';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1Ti3LDr6rZAdaF1K_V4tETeljT1nSe3o3p1M-QGI7YIk/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'thyme';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1qCWjDgPuXsIpXDrL72I81M4pfkVH-kbOy0A_U7PGSB8/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'tulsi';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1xFESEIZvFY90Mw85Mv16C80J9q58LmAV9Rw7PZMfNH4/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'wild cherry';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1CjpHxJ37Bv4FqNhgll0T5L8Ln5uC03zKXYWh32_C5iQ/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'yerba santa';

  -- Nervous
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1LSq7VVrWUnuiwSZO0Uxm0Rtf6aXIQCrf4mKzU9m8RKs/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'ashwagandha';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1xPsYvGrH33JXLLSZlC0NuoKGi__JXR_EjUqFEymtBUw/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'blue vervain';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1nXMTe9mQzks1bxx7ahxqTRmqExx-GIBqV6HgdafTcdk/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'california poppy';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1SN9bIg1ndHFr7bmj6e-30aV16Csi5meQouzYydwNlUk/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'damiana';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/11MG8007dKtoeAsfF0xoLHSShBT_ILK_VvPbg-s87Oiw/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'kava kava';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1nu1boh4TBKm3H6qTsgMY4nuYTD2RunbYNBNIq-YwGPg/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'lemon balm';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1WEoMOIX3mD4Y3Kn0xd9uVYZ9LjFjw4YrB5KlZRD7rtY/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'mimosa';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1IzOLgKND0keNN_NigwgW8oii08xnsFW-Li8U5LEbTfY/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'saint john''s wort';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1Tb3dZuK8jTjSYSGZPK4EsaaXzLE_2FzE_nWIyn4watQ/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'skullcap';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1WR8Om_2UmtiiujOY5voJBiq9c-5_QGBMUMwORMtom7E/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'wild oats';

  -- Cardiovascular
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/15J5JL7ZQVs9qnJV24zawpbWPZ1X1ojob5yRRtANRFrE/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'cayenne';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/19Zo6nksBBS-gy0jYJlz5b4zLS-ItY7MCh6G_mR7kbSI/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'ginkgo';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1w0J53oNgFQyOHdvkHCcJB3w3aMXqYSY5PXsQHX93qdQ/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'hawthorn';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1_Xe6x8u7RsrwFNrCwVwrtrJmJKCzKsW61SYD55gmAi8/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'horse chestnut';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1aNTMRjc7vJcwBLe27ukF8hgxAaECZmEK-YqWA9zRCM0/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'linden';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1EJ3zv2EBaooqh-IB2e5cA8ESDsgNraKZJ1zrYDbrTwo/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'motherwort';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1ozu3SYgon0QJ-fnUKtvx8WguBu8oye2cbDSEoMdKFGg/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'passionflower';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1ftAZgmgNpeYwLZMFi9UW9jBZMwtTQ6A0ubRfXk9y1PM/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'prickly ash';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/1knzVQXKJXlyEG-gHJ8k5c6JCCkF4L3Sd5sp4U0m2V1M/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'siberian ginseng';
  UPDATE herbal.herbs SET monograph_url = 'https://docs.google.com/document/d/13K1S8ZlP79YPqJrdB8gaBRPFMWcWIpZ6ZeFqMiRExcM/edit?usp=classroom_web&authuser=0' WHERE common_name ILIKE 'yarrow';

  RAISE NOTICE 'Monograph URLs populated.';
END $$;
