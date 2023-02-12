Please visit the main README [here](https://github.com/Plant-Coach) on the project's main page.

List of details when you click on a plant:
`Plant Type: <string>`
`Name: <string>`
`Chose to start from seed?: <boolean>`
`Direct Seed Recommended: <boolean>`
`Days to Maturity: <integer>`
`Hybrid Status: <integer>`
`Days to transplant before/after frost date: <integer>`
`Organic: <boolean>`
`Recommended Transplant Date: normal recommended date`
`Planting Status: <string> ["not_started", "started_indoors", "direct_sewn_outside", "transplanted_outside"]` 
`Recommended Seed Sewing Date: <date>`
`Actual Seed Sewing Date: <date>`
`Seedling Days To Transplant: <integer>`
`Actual Transplant Date: <date>`
`Override seed-start date?`
`chosen_overridden_seed-start_date`
`Override transplant date?`
`Chosen Overridden seed-start date`

**Key Attributes for Transition Changes**
    - Chose to start from seed?: `<boolean>`
    - Direct Seed Recommended: `<boolean>`
    - Days to Maturity: `<integer>`
    - Recommended Transplant Date: `<date>`
    - Planting Status: `<string> ["not_started", "started_indoors", "direct_sewn_outside", "transplanted_outside"]` 
    - Recommended Seed Sewing Date: `<date>`
    - Actual Seed Sewing Date: `<date>`
    - Seedling Days To Transplant: `<integer>`
    - Actual Transplant Date: `<date>`
    - Override seed-start date?
    - chosen_overridden_seed-start_date
    - Override transplant date?
    - Chosen Overridden seed-start date

Types of workflows to cover:
Create Plant that is stored in the database
**Future Plantings:**
    - Start from seed (indoors) 
        - Needed Transitions: (-> Started Inside -> Planted Outside -> Harvest)
    - Start from seed (direct seed) 
        - Needed Transitions: (-> Planted Outside -> Harvest)
    - Start from pre-purchased plant 
        - Needed Transitions: (-> Planted Outside)

**Started Plantings:**
    -

---
**Account Creation**
As a User
I can visit `/` and see an option to login or create an account
When I select "Create an Account"
I can create an account with name, email, password, and my zip code
And when I select "Create"
I am taken to an empty dashboard with columns for:
-`My Saved Plants`
-`Plants Waiting to Start`
-`Plants that can be Started by now`
-`Seedlings Growing Inside`
-`Planted Outside`
-`Weather Alerts`
-`My Reminders`
I see buttons for:
-`View Plant Coach Guides`
-`Add a Plant to my Personal List of Plants`
- Each icon on the list has an button to `Add to my Garden`.


---
**Basic Login**
As a registered, but unauthenticated User
I can visit `plantcoach.graden` and select `sign in`
And I am able to enter my email and password and select `"Sign In"`
And I am taken to my dashboard.

---
***Basic Logout***
As a registered, but unauthenticated User
I can visit `plantcoach.graden` and select `sign in`
And I am able to enter my email and password and select `"Sign In"`
And I am taken to my dashboard.
And I see a button that says "Log Out"
And when I click it, I am taken to a logout screen that says "Thank you for using Plant Coach"
And I see a button that says "Log In"
But I do not see a button that says "Log Out"

---
**Add plant to personal database**
As an authenticated user
When I visit my dashboard
I can click "Add a Plant to my Personal Database"
And I am taken to a screen to enter details for:
- Name (optional)
- Plant Type (REQUIRED)
- Days to Maturity (optional)
- Hybrid Status (optional)
- When to start the plant (optional)
- Organic? (checkbox) (optional)
When I click: `Add`
I see feedback that my plant has been added to my list of saved plants.
I am shown a planting guide for that plant type and see sections for:
-`Seed Guide`
-`Transplant Guide`
-`Harvest Guide`
I can select `Close` and see a message that says that I can still access these growing guides at any time.
I am taken back to my Kanban Board/Dashboard and see my newly-created Plant in the "My Saved Plants" list
with a button that says `I want to plant this`.

---
**"I planted a pre-purchased plant"**
As an authenticated User
When I visit my dashboard
I can still see my new plant in the `My Saved Plants` category
I can click a button that says `I want to plant this`
And a window appears that asks if I plan to start the plant from seed
and I select `No`
And a window appears that asks if I have already planted this.
When I select `yes` 
I am I asked `when?` where I can provide today's date.
I am returned to the dashboard where I see my plant in the `Planted Outside` column.
When I click on the plant, I see
    - Chose to start from seed?: `False`
    - Direct Seed Recommended: `No`
    - Actual Transplant Date: `<Today's Date>`
    - Days to Maturity: `<harvest date - actual transplant date>`
    - Recommended Transplant Date: `normal recommended date`
    - Planting Status: `["transplanted_outside"]` 
    - Recommended Seed Sewing Date: `nil`
    - Actual Seed Sewing Date: `nil`
    - Seedling Days To Transplant: `<integer>`
    - Override seed-start date?
    - chosen_overridden_seed-start_date
    - Override transplant date?
    - Chosen Overridden seed-start date

---
**"I want to plant a pre-purchased plant when the apps says the time is right."**
As an authenticated User
When I visit my dashboard
I can still see my new plant in the `My Saved Plants` category
I can click a button that says `I want to plant this`
And a window appears that asks if I plan to start the plant from seed
and I select `No`
And a window appears that asks if I have already planted this.
When I select `No`
I am asked if I would like to set the planting date manually or take the app's advice.
I select `take the apps advice`
I am returned to the dashboard where I see my plant in the `Plants Waiting to Start` column.
And when I click on the plant
    - Chose to start from seed?: `False`
    - Direct Seed Recommended: `No`
    - Actual Transplant Date: `Not yet Transplanted outside`
    - Days to Maturity: `<harvest date - actual transplant date>`
    - Recommended Transplant Date: `normal recommended date`
    - Planting Status: `["not_started"]` 
    - Recommended Seed Sewing Date: `nil`
    - Actual Seed Sewing Date: `nil`
    - Seedling Days To Transplant: `<integer>`
    -- Override seed-start date?
    - chosen_overridden_seed-start_date
    - Override transplant date?
    - Chosen Overridden seed-start date


---
**"I want to plant a pre-purchased plant in the future, and choose my own planting date instead."**
As an authenticated User
When I visit my dashboard
I can still see my new plant in the `My Saved Plants` category
I can click a button that says `I want to plant this`
And a window appears that asks if I plan to start the plant from seed
and I select `No`
And a window appears that asks if I have already planted this.
When I select `No`
I am asked if I would like to set the planting date manually or take the app's advice.
I select `Set Manually`
and I can set the future plant date myself
I am returned to the dashboard where I see my plant in the `Plants Waiting to Start` column.
And when I click on the plant
And I see that start-from-seed is" `False`
And I see my self-chosen transplant date
And I do not see a recommended transplant date
And I do not see a recommended seed-starting date

---
**"I want to plant this from seed - starting inside"**
As an authenticated User
When I visit my dashboard
I can still see my new plant in the `My Saved Plants` category
I can click a button that says `I want to plant this`
And a window appears that asks if I plan to start the plant from seed
and I select `Yes`
And a window appears that asks if I plan to start the seed inside or direct-seed it? (and a recommendation warning is shown)
And I select `Start Inside`
And a window appears that asks if I have already planted this.
When I select `No` 
I am asked if I would like to set the planting date manually or take the app's advice.
I select `take the apps advice`
I am returned to the dashboard where I see my plant in the `Plants Ready to Start` column.
And when I click on the plant,
I see that Starting-From-Seed is: `True`
I see a recommended seed-sewing date
I see that direct-seed is set to `False`
I see a recommended transplant date


---
**"I want to direct-seed"**
As an authenticated User
When I visit my dashboard
I can still see my new plant in the `My Saved Plants` category
I can click a button that says `I want to plant this`
And a window appears that asks if I plan to start the plant from seed
and I select `Yes`
And a window appears that asks if I plant to start the seed inside or direct-seed it? (and a recommendation warning is shown)
And I select `Start Outside`
And a window appears that asks if I have already planted this.
When I select `no`
I am asked if I would like to set the planting date manually or take the app's advice.
I select `take the apps advice`
I am returned to the Dashboard where I see my plant listed under `Plants Ready to Start`
And when I click on the plant,
I can see a recommended seed-sewing date,
I see that direct-seed is set to: `True`
I do not see an actual seed-sewing date
I do not see a recommended transplant date


---
**Status Change - Plant Ready -> Seedlings growing inside**
As an authenticated User
When I visit my dashboard
And I see a Plant in my `Plants Ready to Start` column that is also a plant I want to grow from seed,
I can change the status to `Seedlings Growing Inside`
I am asked when they were started
and I can select:
- Select: `Today`
- Enter a different date (only in the past...)
- `Ok`
And I see the plant in the `Seedlings Growing Inside`.
And when I look at the seedling information,
I can see a recommended transplant outside, an actual seed sewing date (that is today) but not an actual transplant date

---
User Story in which a seed starting date
As an authenticated User
When I visit my dashboard
And I see a Plant in my `Plants Ready to Start` column
I can change the status to `Seedlings Growing Inside`
I am asked when they were started
and when I select:
Select date
and select a date in the future,
I see a flash message that dates must only be today or in the past.
When I select an appropriate date,
I can select `Ok`
And I see the plant in the `Seedlings Growing Inside`.

---
User Story in which a seed starting date
As an authenticated User
When I visit my dashboard
And I see a Plant in my `Plants Ready to Start` column
I can change the status to `Planted Outside`
I am asked when it was planted outside
and I see options for:
- `Today`
- `<select date>`
When I select today
Then select `Ok`
Then I can see the plant in the `Planted Outside` column.

---
As an Authenticated User
When I visit my dashboard
And I click on the name of the plant that is in the `Planted Outside` column,
I then see:
- A link to go to the plant guide
- An estimated harvest date or range
- The date that the plant was started
- The date that the seeds were started (if applicable)
- Organic
- Plant Type
- Name
- Hybrid Status
- Planting Status
- Link: "My Notes on #{plant_type}s #{<number of entries>}"

---
As an Authenticated User
When I visit my dashboard
And I click on the name of the plant that is in the `Planted Outside` column,
and I click the link to go to the plant guide
I am taken to a page where I see the complete information available in the plant guide

---
Move Plant backwards/accidental status update

---
Add Journal entry to a garden_plant

---
Scroll down to see a calendar where I can see the events of each garden plant

---
When an plant has not been started yet but is within 1 week of the recommended seed-starting date,
