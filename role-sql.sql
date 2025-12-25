-- =====================================================
-- SQL for Stock Transfer Module Permissions
-- Run this to add permissions to your role system
-- =====================================================

-- 1. First, insert the permissions into permissions table
INSERT INTO permissions (permission_key, permission_name, module, description, created_at) VALUES
('stock_transfer_view', 'View Stock Transfers', 'Stock Transfer', 'Can view stock transfer list and details', NOW()),
('stock_transfer_create', 'Create Stock Transfer', 'Stock Transfer', 'Can create new stock transfers', NOW()),
('stock_transfer_edit', 'Edit Stock Transfer', 'Stock Transfer', 'Can edit pending stock transfers', NOW()),
('stock_transfer_delete', 'Delete Stock Transfer', 'Stock Transfer', 'Can delete/cancel stock transfers', NOW()),
('stock_transfer_approve', 'Approve Stock Transfer', 'Stock Transfer', 'Can approve and change transfer status', NOW());

-- 2. Get the permission IDs (adjust based on your table structure)
SET @view_id = (SELECT id FROM permissions WHERE permission_key = 'stock_transfer_view');
SET @create_id = (SELECT id FROM permissions WHERE permission_key = 'stock_transfer_create');
SET @edit_id = (SELECT id FROM permissions WHERE permission_key = 'stock_transfer_edit');
SET @delete_id = (SELECT id FROM permissions WHERE permission_key = 'stock_transfer_delete');
SET @approve_id = (SELECT id FROM permissions WHERE permission_key = 'stock_transfer_approve');

-- 3. Assign ALL permissions to Admin role (role_id = 1)
INSERT INTO role_permissions (role_id, permission_id, created_at) VALUES
(1, @view_id, NOW()),
(1, @create_id, NOW()),
(1, @edit_id, NOW()),
(1, @delete_id, NOW()),
(1, @approve_id, NOW());

-- 4. Assign limited permissions to Manager role (role_id = 2)
INSERT INTO role_permissions (role_id, permission_id, created_at) VALUES
(2, @view_id, NOW()),
(2, @create_id, NOW()),
(2, @edit_id, NOW()),
(2, @approve_id, NOW());

-- 5. Assign basic permissions to Stock Keeper role (role_id = 3)
INSERT INTO role_permissions (role_id, permission_id, created_at) VALUES
(3, @view_id, NOW()),
(3, @create_id, NOW());

-- 6. Assign view only to Cashier role (role_id = 4)
INSERT INTO role_permissions (role_id, permission_id, created_at) VALUES
(4, @view_id, NOW());

-- =====================================================
-- ALTERNATIVE: If you use a simpler role table structure
-- with JSON or comma-separated permissions
-- =====================================================

-- Option A: Update role with JSON permissions
UPDATE roles SET permissions = JSON_ARRAY_APPEND(
    COALESCE(permissions, '[]'), 
    '$', 
    'stock_transfer_view',
    '$',
    'stock_transfer_create',
    '$',
    'stock_transfer_edit',
    '$',
    'stock_transfer_delete',
    '$',
    'stock_transfer_approve'
) WHERE id = 1; -- Admin

-- Option B: If permissions is TEXT/VARCHAR with comma-separated values
UPDATE roles 
SET permissions = CONCAT(IFNULL(permissions, ''), ',stock_transfer_view,stock_transfer_create,stock_transfer_edit,stock_transfer_delete,stock_transfer_approve')
WHERE id = 1; -- Admin

UPDATE roles 
SET permissions = CONCAT(IFNULL(permissions, ''), ',stock_transfer_view,stock_transfer_create,stock_transfer_edit,stock_transfer_approve')
WHERE id = 2; -- Manager

UPDATE roles 
SET permissions = CONCAT(IFNULL(permissions, ''), ',stock_transfer_view,stock_transfer_create')
WHERE id = 3; -- Stock Keeper

UPDATE roles 
SET permissions = CONCAT(IFNULL(permissions, ''), ',stock_transfer_view')
WHERE id = 4; -- Cashier

-- =====================================================
-- Language Keys for translations table
-- =====================================================

INSERT INTO translations (lang_key, lang_code, translation) VALUES
-- English
('page_title_transfer', 'en', 'Product Transfer - FreshMart POS'),
('stock_transfer', 'en', 'Stock Transfer'),
('transfer_desc', 'en', 'Transfer products between branches'),
('status_pending', 'en', '📋 Pending'),
('status_in_transit', 'en', '🚚 In Transit'),
('status_completed', 'en', '✅ Completed'),
('status_cancelled', 'en', '❌ Cancelled'),
('btn_save_transfer', 'en', 'Save Transfer'),
('transfer_info', 'en', 'Transfer Information'),
('select_branches', 'en', 'Select source and destination branches'),
('from_branch', 'en', 'From Branch *'),
('to_branch', 'en', 'To Branch *'),
('select_source', 'en', '-- Select Source --'),
('select_destination', 'en', '-- Select Destination --'),
('transfer_date', 'en', 'Transfer Date'),
('scan_barcode', 'en', 'Scan Barcode'),
('search_products', 'en', 'Search products by name or SKU...'),
('all_categories', 'en', 'All Categories'),
('all', 'en', 'All'),
('transfer_items', 'en', 'Transfer Items'),
('clear_all', 'en', 'Clear All'),
('th_product', 'en', 'Product'),
('th_stock', 'en', 'Stock'),
('th_qty', 'en', 'Qty'),
('th_cost', 'en', 'Cost'),
('th_total', 'en', 'Total'),
('no_items_added', 'en', 'No items added'),
('scan_or_search', 'en', 'Scan barcode or search products'),
('transfer_notes', 'en', 'Transfer Notes'),
('notes_placeholder', 'en', 'Reason for transfer or special instructions...'),
('transfer_summary', 'en', 'Transfer Summary'),
('total_items', 'en', 'Total Items'),
('total_quantity', 'en', 'Total Quantity'),
('total_value', 'en', 'TOTAL VALUE'),
('transfer_details', 'en', 'Transfer Details'),
('from', 'en', 'From:'),
('to', 'en', 'To:'),
('date', 'en', 'Date:'),
('not_selected', 'en', 'Not selected'),
('items', 'en', 'Items'),
('value', 'en', 'Value'),
('btn_cancel', 'en', 'Cancel'),
('transfer_saved', 'en', 'Transfer Saved!'),
('btn_new_transfer', 'en', 'New Transfer'),
('btn_done', 'en', 'Done'),
('select_source_first', 'en', 'Please select source branch first'),
('product_not_found', 'en', 'Product not found'),
('no_stock', 'en', 'No stock available in selected branch'),
('exceed_stock', 'en', 'Cannot exceed available stock'),
('no_products_found', 'en', 'No products found'),
('add_items', 'en', 'Add items to transfer'),
('select_source', 'en', 'Select source branch'),
('select_dest', 'en', 'Select destination branch'),
('same_branch_error', 'en', 'Source and destination cannot be same'),
('items_transferred', 'en', 'items transferred'),
('error_saving', 'en', 'Error saving transfer'),

-- Bangla (bn)
('page_title_transfer', 'bn', 'পণ্য স্থানান্তর - ফ্রেশমার্ট পিওএস'),
('stock_transfer', 'bn', 'স্টক স্থানান্তর'),
('transfer_desc', 'bn', 'শাখাগুলির মধ্যে পণ্য স্থানান্তর করুন'),
('status_pending', 'bn', '📋 অপেক্ষমান'),
('status_in_transit', 'bn', '🚚 পরিবহনে'),
('status_completed', 'bn', '✅ সম্পন্ন'),
('status_cancelled', 'bn', '❌ বাতিল'),
('btn_save_transfer', 'bn', 'স্থানান্তর সংরক্ষণ'),
('transfer_info', 'bn', 'স্থানান্তর তথ্য'),
('select_branches', 'bn', 'উৎস এবং গন্তব্য শাখা নির্বাচন করুন'),
('from_branch', 'bn', 'উৎস শাখা *'),
('to_branch', 'bn', 'গন্তব্য শাখা *'),
('select_source', 'bn', '-- উৎস নির্বাচন --'),
('select_destination', 'bn', '-- গন্তব্য নির্বাচন --'),
('transfer_date', 'bn', 'স্থানান্তর তারিখ'),
('scan_barcode', 'bn', 'বারকোড স্ক্যান'),
('search_products', 'bn', 'নাম বা SKU দিয়ে পণ্য খুঁজুন...'),
('all_categories', 'bn', 'সব ক্যাটাগরি'),
('all', 'bn', 'সব'),
('transfer_items', 'bn', 'স্থানান্তর আইটেম'),
('clear_all', 'bn', 'সব মুছুন'),
('th_product', 'bn', 'পণ্য'),
('th_stock', 'bn', 'স্টক'),
('th_qty', 'bn', 'পরিমাণ'),
('th_cost', 'bn', 'মূল্য'),
('th_total', 'bn', 'মোট'),
('no_items_added', 'bn', 'কোন আইটেম যোগ করা হয়নি'),
('scan_or_search', 'bn', 'বারকোড স্ক্যান বা পণ্য খুঁজুন'),
('transfer_notes', 'bn', 'স্থানান্তর নোট'),
('notes_placeholder', 'bn', 'স্থানান্তরের কারণ বা বিশেষ নির্দেশনা...'),
('transfer_summary', 'bn', 'স্থানান্তর সারাংশ'),
('total_items', 'bn', 'মোট আইটেম'),
('total_quantity', 'bn', 'মোট পরিমাণ'),
('total_value', 'bn', 'মোট মূল্য'),
('transfer_details', 'bn', 'স্থানান্তর বিবরণ'),
('from', 'bn', 'উৎস:'),
('to', 'bn', 'গন্তব্য:'),
('date', 'bn', 'তারিখ:'),
('not_selected', 'bn', 'নির্বাচন করা হয়নি'),
('items', 'bn', 'আইটেম'),
('value', 'bn', 'মূল্য'),
('btn_cancel', 'bn', 'বাতিল'),
('transfer_saved', 'bn', 'স্থানান্তর সংরক্ষিত!'),
('btn_new_transfer', 'bn', 'নতুন স্থানান্তর'),
('btn_done', 'bn', 'সম্পন্ন'),
('select_source_first', 'bn', 'প্রথমে উৎস শাখা নির্বাচন করুন'),
('product_not_found', 'bn', 'পণ্য পাওয়া যায়নি'),
('no_stock', 'bn', 'নির্বাচিত শাখায় স্টক নেই'),
('exceed_stock', 'bn', 'উপলব্ধ স্টকের বেশি হতে পারে না'),
('no_products_found', 'bn', 'কোন পণ্য পাওয়া যায়নি'),
('add_items', 'bn', 'স্থানান্তরে আইটেম যোগ করুন'),
('same_branch_error', 'bn', 'উৎস এবং গন্তব্য একই হতে পারে না'),
('items_transferred', 'bn', 'আইটেম স্থানান্তরিত'),
('error_saving', 'bn', 'স্থানান্তর সংরক্ষণে ত্রুটি');
