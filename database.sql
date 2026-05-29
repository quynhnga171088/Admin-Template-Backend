/*
 Navicat Premium Data Transfer

 Source Server         : lms_db
 Source Server Type    : PostgreSQL
 Source Server Version : 150018 (150018)
 Source Host           : localhost:5432
 Source Catalog        : lms_db
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 150018 (150018)
 File Encoding         : 65001

 Date: 29/05/2026 15:16:26
*/


-- ----------------------------
-- Type structure for course_status
-- ----------------------------
DROP TYPE IF EXISTS "course_status";
CREATE TYPE "course_status" AS ENUM (
  'DRAFT',
  'PUBLISHED',
  'ARCHIVED'
);
ALTER TYPE "course_status" OWNER TO "lms_user";

-- ----------------------------
-- Type structure for enrollment_status
-- ----------------------------
DROP TYPE IF EXISTS "enrollment_status";
CREATE TYPE "enrollment_status" AS ENUM (
  'PENDING',
  'APPROVED',
  'REJECTED'
);
ALTER TYPE "enrollment_status" OWNER TO "lms_user";

-- ----------------------------
-- Type structure for progress_status
-- ----------------------------
DROP TYPE IF EXISTS "progress_status";
CREATE TYPE "progress_status" AS ENUM (
  'NOT_STARTED',
  'IN_PROGRESS',
  'COMPLETED'
);
ALTER TYPE "progress_status" OWNER TO "lms_user";

-- ----------------------------
-- Type structure for section_status
-- ----------------------------
DROP TYPE IF EXISTS "section_status";
CREATE TYPE "section_status" AS ENUM (
  'DRAFT',
  'PUBLISHED'
);
ALTER TYPE "section_status" OWNER TO "lms_user";

-- ----------------------------
-- Type structure for section_type
-- ----------------------------
DROP TYPE IF EXISTS "section_type";
CREATE TYPE "section_type" AS ENUM (
  'VIDEO',
  'TEXT'
);
ALTER TYPE "section_type" OWNER TO "lms_user";

-- ----------------------------
-- Type structure for user_role
-- ----------------------------
DROP TYPE IF EXISTS "user_role";
CREATE TYPE "user_role" AS ENUM (
  'STUDENT',
  'TEACHER',
  'ADMIN'
);
ALTER TYPE "user_role" OWNER TO "lms_user";

-- ----------------------------
-- Type structure for user_status
-- ----------------------------
DROP TYPE IF EXISTS "user_status";
CREATE TYPE "user_status" AS ENUM (
  'ACTIVE',
  'BLOCKED'
);
ALTER TYPE "user_status" OWNER TO "lms_user";

-- ----------------------------
-- Sequence structure for bank_info_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "bank_info_id_seq";
CREATE SEQUENCE "bank_info_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for chapters_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "chapters_id_seq";
CREATE SEQUENCE "chapters_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for courses_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "courses_id_seq";
CREATE SEQUENCE "courses_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for enrollments_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "enrollments_id_seq";
CREATE SEQUENCE "enrollments_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for lesson_attachments_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "lesson_attachments_id_seq";
CREATE SEQUENCE "lesson_attachments_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for lesson_progress_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "lesson_progress_id_seq";
CREATE SEQUENCE "lesson_progress_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for lessons_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "lessons_id_seq";
CREATE SEQUENCE "lessons_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for payment_proofs_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "payment_proofs_id_seq";
CREATE SEQUENCE "payment_proofs_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for refresh_tokens_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "refresh_tokens_id_seq";
CREATE SEQUENCE "refresh_tokens_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for sections_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "sections_id_seq";
CREATE SEQUENCE "sections_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for system_configs_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "system_configs_id_seq";
CREATE SEQUENCE "system_configs_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for users_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "users_id_seq";
CREATE SEQUENCE "users_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Table structure for bank_info
-- ----------------------------
DROP TABLE IF EXISTS "bank_info";
CREATE TABLE "bank_info" (
  "id" int4 NOT NULL DEFAULT nextval('bank_info_id_seq'::regclass),
  "bank_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "account_number" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "account_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "branch" varchar(255) COLLATE "pg_catalog"."default",
  "transfer_template" text COLLATE "pg_catalog"."default",
  "qr_image_url" text COLLATE "pg_catalog"."default",
  "updated_by" int8,
  "updated_at" timestamp(6) NOT NULL DEFAULT now()
)
;

-- ----------------------------
-- Records of bank_info
-- ----------------------------
BEGIN;
INSERT INTO "bank_info" ("id", "bank_name", "account_number", "account_name", "branch", "transfer_template", "qr_image_url", "updated_by", "updated_at") VALUES (1, 'Vietcombank', '1234567890', 'NGUYEN VAN A', 'Chi nhánh Hà Nội', 'LMS [MaHV] [TenKhoa]', NULL, NULL, '2026-05-18 14:05:09.639747');
COMMIT;

-- ----------------------------
-- Table structure for chapters
-- ----------------------------
DROP TABLE IF EXISTS "chapters";
CREATE TABLE "chapters" (
  "id" int8 NOT NULL DEFAULT nextval('chapters_id_seq'::regclass),
  "course_id" int8 NOT NULL,
  "title" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "order_index" int4 NOT NULL DEFAULT 0,
  "created_at" timestamp(6) NOT NULL DEFAULT now(),
  "updated_at" timestamp(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamp(6),
  "description" text COLLATE "pg_catalog"."default",
  "avatar_url" varchar(2000) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of chapters
-- ----------------------------
BEGIN;
INSERT INTO "chapters" ("id", "course_id", "title", "order_index", "created_at", "updated_at", "deleted_at", "description", "avatar_url") VALUES (1, 20, 'Chapter 1', 0, '2026-05-25 15:45:51.090911', '2026-05-25 16:06:28.789216', '2026-05-25 16:06:28.788189', NULL, NULL), (2, 20, 'Course Introduction', 1, '2026-05-25 16:09:02.398803', '2026-05-26 14:50:37.495376', NULL, 'In this module, we will provide an overview of the course and its curriculum. You''ll learn about the breadth of topics covered, from foundational concepts to advanced implementations in Python. This section sets the stage for your journey into data structures and algorithms, emphasizing their role in technical problem-solving and interviews.', 'https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://coursera_assets.s3.amazonaws.com/images/a7c5400e51272c78b710ce9b56fd3178.png?auto=format%2Ccompress&dpr=1&w=562&h=221&q=40&fit=crop'), (3, 20, 'Big O Notation', 0, '2026-05-25 16:11:30.167072', '2026-05-26 14:50:37.496419', NULL, 'In this module, we will delve into the fundamentals of Big O notation, a critical tool for analyzing algorithm efficiency. Through detailed explanations and examples, you''ll explore various complexities, learn to count operations, and simplify Big O expressions. By the end of this section, you’ll also gain insights into space complexity and its impact on data structure design.', 'https://sohanews.sohacdn.com/zoom/346_216/160588918557773824/2026/5/25/avatar1779695218190-1779695220921313617984.jpg'), (4, 20, 'Advanced Data Analytics', 2, '2026-05-26 15:43:47.953583', '2026-05-26 15:43:47.953583', NULL, 'After seven courses, you’ll be prepared for jobs like senior data analyst, junior data scientist, data science analyst, and more. At under 10 hours a week, the certificate program can be completed in less than six months. Upon completion, you can apply for jobs with Google and over 150 U.S. employers, including Deloitte, Target, and Verizon.', 'https://static.vecteezy.com/system/resources/thumbnails/049/855/347/small/nature-background-high-resolution-wallpaper-for-a-serene-and-stunning-view-photo.jpg');
COMMIT;

-- ----------------------------
-- Table structure for courses
-- ----------------------------
DROP TABLE IF EXISTS "courses";
CREATE TABLE "courses" (
  "id" int8 NOT NULL DEFAULT nextval('courses_id_seq'::regclass),
  "title" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "slug" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "short_description" varchar(500) COLLATE "pg_catalog"."default",
  "thumbnail_url" text COLLATE "pg_catalog"."default",
  "price" numeric(15,2) NOT NULL DEFAULT 0,
  "status" "public"."course_status" NOT NULL DEFAULT 'DRAFT'::course_status,
  "teacher_id" int8 NOT NULL,
  "created_by" int8 NOT NULL,
  "published_at" timestamp(6),
  "created_at" timestamp(6) NOT NULL DEFAULT now(),
  "updated_at" timestamp(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamp(6)
)
;

-- ----------------------------
-- Records of courses
-- ----------------------------
BEGIN;
INSERT INTO "courses" ("id", "title", "slug", "description", "short_description", "thumbnail_url", "price", "status", "teacher_id", "created_by", "published_at", "created_at", "updated_at", "deleted_at") VALUES (3, 'Trade Coin Underground', 'trade-coin-underground', 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don''t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn''t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators o', 'Trade Coin Underground Trade Coin Underground', 'http://localhost:8080/uploads/images/avatar/7fdc28abfc0f4fc48ffecf3928350030.jpg', 600000.00, 'ARCHIVED', 1, 1, NULL, '2026-05-22 14:36:45.071757', '2026-05-22 14:36:45.071757', NULL), (1, 'Nhập Môn Tin Học', 'nhap-mon-tin-hoc', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in', '', 1000000.00, 'DRAFT', 1, 1, NULL, '2026-05-21 13:20:47.314275', '2026-05-21 13:20:47.314275', NULL), (7, 'Thông tin cơ bản về AI của Google', 'thong-tin-co-ban-ve-ai-cua-google', 'Tăng năng suất của bạn với các công cụ AI.

Bạn mới sử dụng AI? Tìm hiểu từ các chuyên gia của Google về cách AI có thể giúp bạn tăng tốc các công việc hàng ngày và khơi dậy những ý tưởng mới.', 'Sử dụng các công cụ AI tổng hợp để giúp phát triển ý tưởng và nội dung, đưa ra quyết định sáng suốt hơn và tăng tốc các công việc hàng ngày', 'http://localhost:8080/uploads/images/avatar/8e73a580a3724cc9bf4bc423abba5a19.jpg', 1100000.00, 'PUBLISHED', 1, 1, NULL, '2026-05-22 14:48:11.931561', '2026-05-22 14:48:11.932079', NULL), (5, 'Google AI', 'google-ai', 'Nâng cao khả năng sử dụng AI để hoàn thành công việc nhanh hơn, hiệu quả hơn.

Sở hữu những kỹ năng AI mà các nhà tuyển dụng đang săn đón và xây dựng hơn 20 giải pháp có áp dụng ngay.', 'Chứng chỉ chuyên môn về AI của Google', 'http://localhost:8080/uploads/images/avatar/3de7cebc664341929a4930e99f000841.jpg', 100000.00, 'DRAFT', 1, 1, NULL, '2026-05-22 14:41:03.956547', '2026-05-22 14:41:03.956547', NULL), (2, 'Tin Học Đại Cương', 'tin-hoc-ai-cuong', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in', 'http://localhost:8080/uploads/images/avatar/6acc41d9a06b40f3b2f70b0ed1e76bf9.jpg', 500000.00, 'PUBLISHED', 1, 1, NULL, '2026-05-21 13:26:15.749059', '2026-05-21 13:26:15.749059', NULL), (4, 'Prompt Engineering', 'prompt-engineering', 'Learn to augment and amplify your human creativity and critical thinking with Generative AI. By the end of the course, you will be able to use Generative AI as an exoskeleton for your mind. In this hands-on specialization, you will learn how to tap into the emerging capabilities of large language models to automate tasks, increase productivity, and augment human intelligence. Through ', 'Learn to augment and amplify your human.', 'http://localhost:8080/uploads/images/avatar/fb3ca70f61f6407baacffed19a06adc2.jpg', 300000.00, 'ARCHIVED', 1, 1, NULL, '2026-05-22 14:39:55.258495', '2026-05-22 14:39:55.258495', NULL), (6, 'Building AI Agents and Agentic', 'building-ai-agents-and-agentic', 'Build Autonomous Applications with AI Agents.

Master Agentic AI with multi-agent frameworks such as LangGraph, CrewAI, BeeAI, and AG2 (AutoGen)', 'Workflow Build Autonomous Applications with AI Agents.  Master Agentic AI with multi-agent frameworks such as LangGraph, CrewAI, BeeAI, and AG2 (AutoGen)', 'http://localhost:8080/uploads/images/avatar/f61995a25aa14e97a37da84960e97b19.jpg', 400000.00, 'DRAFT', 1, 1, NULL, '2026-05-22 14:47:26.246893', '2026-05-22 14:47:26.246893', NULL), (8, 'Accelerate Your Job Search with AI', 'accelerate-your-job-search-with-ai', 'All Google Career Certificates now include an optional course, Accelerate Your Job Search with AI. This course was designed by experts at Google and informed by employers, workforce nonprofits, and educational institutions, to help you navigate your path to your next role more efficiently and confidently. No matter where you are on your job search  journey—whether you''re just starting out, seeking a new challenge, or ready for your next career move—this course is for everyone. 

You’ll get practical job search strategies and learn how to leverage AI tools (like Gemini and NotebookLM) to uncover your most valuable skills, create a job search plan, manage your applications, and practice for interviews. You’ll walk away with a personalized job search portfolio to help you stand out to employers, including a resume, career identity statement, job search plan tracker, and more. No previous AI experience is required.', 'Uncover your skills and explore new career possibilities, with support from tools like Career Dreamer.', 'http://localhost:8080/uploads/images/avatar/ce3802d5e9a9473a8985d193f45ba4d7.jpg', 3000000.00, 'DRAFT', 1, 1, NULL, '2026-05-22 14:54:27.12291', '2026-05-22 14:54:27.12291', NULL), (9, 'Machine Learning Made Easy for Software Engineers', 'machine-learning-made-easy-for-software-engineers', 'Machine learning is increasingly integrated into modern software systems. This specialization helps software engineers build practical machine learning capabilities that extend beyond model training into full production workflows.
You’ll begin by learning how to map business problems to machine learning tasks and train predictive models using common M', 'Build and Deploy Production ML Systems.  Learn to build, optimize, deploy, and monitor machine learning systems as a software engineer.', 'http://localhost:8080/uploads/images/avatar/d616184954dc407eb7691447f7ff44d1.jpg', 4500000.00, 'PUBLISHED', 1, 1, NULL, '2026-05-22 14:57:06.303343', '2026-05-22 14:57:06.303343', NULL), (12, 'Model Context Protocol (MCP) Mastery', 'model-context-protocol-mcp-mastery', 'In this short, intensive course, you’ll dive into the Model Context Protocol (MCP)—an open standard revolutionizing AI connectivity. Just as HTTP and REST reshaped the web, MCP is redefining how AI models communicate, enabling seamless, secure, and scalable integration with external systems.', 'The evolution of MCP and its impact on AI integration.  MCP’s modular architecture: hosts, clients, servers, and ', 'http://localhost:8080/uploads/images/avatar/72c5e9fd71a54a5cad36ebcf53c894be.jpg', 3000000.00, 'DRAFT', 1, 1, NULL, '2026-05-22 15:19:21.694941', '2026-05-22 15:19:21.694941', NULL), (16, 'IT Skills Track', 'it-skills-track', 'Protect your organization with cybersecurity, IT operations, and network administration learning paths through a trusted business learning platform. Strengthen security and manage evolving risks with scalable training built for enterprise agility.', 'Skills-based learning for teams of all sizes', 'http://localhost:8080/uploads/images/avatar/06307ffed9f04aeb8ec17626fdea3f86.jpg', 2400000.00, 'DRAFT', 1, 1, NULL, '2026-05-22 16:12:13.250805', '2026-05-22 16:12:13.250805', NULL), (10, 'Hands-on Agentic AI: Building Intelligent Agents', 'hands-on-agentic-ai-building-intelligent-agents', 'Transform your AI development capabilities with comprehensive training in agentic AI systems—the future of autonomous, intelligent applications. This 8-course program equips you to design, build, and govern multi-agent systems that collaborate, reason, and solve complex problems at scale. You''ll master the Model Context Protocol (MCP) for standardized AI integration, implement ', 'Implement industry-standard protocols like MCP and build stateful AI workflows using LangGraph framework.', 'http://localhost:8080/uploads/images/avatar/2dfecb01213e4a06956d5e91cceec618.jpg', 200000.00, 'DRAFT', 1, 1, NULL, '2026-05-22 15:17:33.234879', '2026-05-22 15:17:33.234879', NULL), (13, 'In this short, intensive course', 'in-this-short-intensive-course', 'Trong khóa học này, bạn sẽ khám phá cách xây dựng các ứng dụng AI mạnh mẽ bằng cách sử dụng Giao thức bối cảnh mô hình, một cách tiếp cận mang tính cách mạng giúp loại bỏ mã tích hợp tẻ nhạt khi kết nối Claude với các dịch vụ và nguồn dữ liệu bên ngoài. Khóa học này đưa bạn từ việc hiểu kiến trúc cốt lõi của MCP đến việc xây dựng các máy chủ và máy khách MCP đầy đủ chức năng có', 'Có thể tham gia các khóa học theo tốc độ và nhịp điệu của riêng tôi là một trải nghiệm tuyệt vời. Tôi có thể học bất cứ khi nào phù hợp với lịch trình và tâm trạng của tôi.', 'http://localhost:8080/uploads/images/avatar/423a5cd5e3a34e96a85cfef2f86ab1b1.jpg', 880000.00, 'PUBLISHED', 1, 1, NULL, '2026-05-22 15:21:47.963853', '2026-05-22 15:21:47.963853', NULL), (11, 'MCP - Model Content Protocol', 'mcp-model-content-protocol', 'Mastering MCP: Transform AI Integration with Open Standards is an advanced-level course designed for AI engineers, data scientists, and technical architects who want to revolutionize how AI systems connect with external data sources. In today''s fragmented AI landscape, integration challenges consume development time and create security vulnerabilities. This course teaches you to ', 'Khóa học này là một phần của Hands-on Agentic AI: Building Intelligent Agents Chuyên ngành Khi bạn đăng ký khóa học này, bạn cũng sẽ được ghi danh vào chuyên ngành này.', 'http://localhost:8080/uploads/images/avatar/11ba7bb23be14d3cba9797af7b2de787.jpg', 5500000.00, 'ARCHIVED', 1, 1, NULL, '2026-05-22 15:18:18.535145', '2026-05-22 15:18:18.535145', NULL), (15, 'Learn from the world’s most innovative companies', 'learn-from-the-worlds-most-innovative-companies', 'Each Skills Track offers a focused, measurable journey powered by a leading online learning platform for business. Keep teams ahead with up-to-date content that drives agility, security, service excellence, and competitive advantage in a fast-changing economy.', 'Save on training costs with tailored content and industry-recognized credentials from over 350+ leading companies and universities.', 'http://localhost:8080/uploads/images/avatar/78af8877db6d4fdd8386a0f688dcba6b.jpg', 300000.00, 'ARCHIVED', 1, 1, NULL, '2026-05-22 16:11:18.069827', '2026-05-22 16:11:18.069827', NULL), (14, 'Giao thức ngữ cảnh mô hình', 'giao-thuc-ngu-canh-mo-hinh', 'Khóa học này dạy bạn xây dựng các máy chủ và máy khách giao thức ngữ cảnh mô hình (MCP) với các tính năng sẵn sàng sản xuất. Bạn sẽ học cách triển khai lấy mẫu — một kỹ thuật chuyển chi phí và độ phức tạp của mô hình AI từ máy chủ sang máy khách — đồng thời thêm ghi nhật ký thời gian thực và thông báo tiến độ để cải thiện trải nghiệm người dùng trong các hoạt động lâu dài. Khóa học bao gồm root, hệ thống cấp phép của MCP cho phép khám phá tệp trong khi vẫn duy trì ranh giới bảo mật.', 'Xem nhân viên tại các công ty hàng đầu đang nắm vững các kỹ năng thiết yếu như thế nào', 'http://localhost:8080/uploads/images/avatar/b001afea490249a69a9a34bb417a3021.jpg', 660000.00, 'DRAFT', 1, 1, NULL, '2026-05-22 16:10:23.153965', '2026-05-22 16:10:23.153965', NULL), (17, 'At Coursera, learning isn''t just what we do', 'at-coursera-learning-isnt-just-what-we-do', 'We’re a global community of inventors, innovators, and lifelong learners united by a shared mission: to transform lives through learning. Together, we’re redefining how people learn, work, and grow. Our North Star is to be the place where the world’s learners master the right skills to grow their careers, and every Courserian plays a role in expanding access to world-class education and building learning experiences that matter. If you’re passionate about education, technology, and creating meaningful impact at scale, you’ll find a place to grow here.', 'At Coursera, learning isn''t just what we do, it''s who we are.', 'http://localhost:8080/uploads/images/avatar/d8557a69a3044060ace7f4bc91f46dbe.jpg', 490000.00, 'DRAFT', 1, 1, NULL, '2026-05-25 09:18:16.611982', '2026-05-25 09:18:16.611982', NULL), (20, 'Introduction to Data Structures and Algorithmic Foundations', 'introduction-to-data-structures-and-algorithmic-foundations', 'This course features Coursera Coach!

A smarter way to learn with interactive, real-time conversations that help you test your knowledge, challenge assumptions, and deepen your understanding as you progress through the course.

Build a strong foundation in data structures and algorithms to confidently tackle coding interviews and real-world problem solving. You will learn how to analyze time and space complexity, apply Big O notation, and understand how efficient code impacts performance. Through hands-on practice, you will strengthen your logical thinking and develop a problem-solving mindset essential for technical roles.

The course begins with an introduction to coding interview preparation using Leetcode, guiding you on how to approach problems strategically. It then dives deep into time and space complexity, covering both theoretical concepts and practical examples, including recursive cases and live demonstrations to reinforce your understanding.

As you progress, you will explore core data structures such as arrays, linked lists, and hash tables, learning their strengths, limitations, and real-world applications. Each section is paired with carefully selected problems, including popular interview questions like Two Sum, Maximum Subarray, and Linked List Cycle, enabling you to apply concepts effectively.

This course is ideal for aspiring software engineers, students, and professionals preparing for coding interviews. Basic programming knowledge is recommended, and the course is designed at a beginner to intermediate level for gradual skill development.', 'Analyze algorithm efficiency using time and space complexity, including recursive cases, to write optimized and scalable solutions.
Apply Big O notation confidently to evaluate and compare different algorithmic approaches in coding interviews and real-world scenarios.', 'http://localhost:8080/uploads/images/avatar/7095b87b8e744d32bb0d10f01bae6043.jpg', 500000.00, 'PUBLISHED', 1, 1, '2026-05-25 11:33:25.741006', '2026-05-25 11:33:11.404321', '2026-05-25 11:33:25.742075', NULL), (19, 'Interview Questions and Real-World Applications.', 'interview-questions-and-real-world-applications', 'Master the essential data structures and algorithms that form the foundation of programming problem-solving. In this practical, project-driven course, you’ll work through real-world interview questions and coding challenges to strengthen your logic, sharpen your skills, and build the confidence to tackle technical assessments and professional projects.', 'Master key techniques for implementing data structures like stacks, queues, and linked lists. Develop problem-solving strategies for coding interview challenges', 'http://localhost:8080/uploads/images/avatar/4a3dbf29d73243119070f7b4a2ae458f.jpg', 3000000.00, 'PUBLISHED', 1, 1, '2026-05-25 11:31:26.009922', '2026-05-25 10:32:48.350865', '2026-05-25 11:31:26.010427', NULL), (18, 'Ace the Computer Science Interview', 'ace-the-computer-science-interview', 'This course is designed to empower individuals preparing for computer science job interviews, with essential strategies to confidently navigate the computer science interview process. It will provide a comprehensive overview of the key concepts, tips, and techniques required to succeed in securing your dream role. From preparing for common interview questions to developing practical coding strategies, this course aims to ensure you are well-equipped for the challenges ahead.

This course is ideal for computer science graduates, entry-level tech job seekers, and professionals transitioning into tech roles. It is also suited for individuals looking to sharpen their interview skills and gain a competitive edge in computer science positions.

To benefit fully from this course, you should have a basic understanding of programming and common data structures and algorithms. Additionally, an interest in developing effective communication skills and a strong motivation to succeed in computer science interviews are essential.', 'Evaluate the importance of interview preparation and the structure of successful strategies.', 'http://localhost:8080/uploads/images/avatar/19ff3a8b70b04fe59c71ce64b77a7153.jpeg', 500000.00, 'DRAFT', 1, 1, NULL, '2026-05-25 10:29:19.665279', '2026-05-26 10:55:44.746626', NULL);
COMMIT;

-- ----------------------------
-- Table structure for enrollments
-- ----------------------------
DROP TABLE IF EXISTS "enrollments";
CREATE TABLE "enrollments" (
  "id" int8 NOT NULL DEFAULT nextval('enrollments_id_seq'::regclass),
  "student_id" int8 NOT NULL,
  "course_id" int8 NOT NULL,
  "status" "public"."enrollment_status" NOT NULL DEFAULT 'PENDING'::enrollment_status,
  "note" text COLLATE "pg_catalog"."default",
  "reviewed_by" int8,
  "reviewed_at" timestamp(6),
  "created_at" timestamp(6) NOT NULL DEFAULT now(),
  "updated_at" timestamp(6) NOT NULL DEFAULT now()
)
;

-- ----------------------------
-- Records of enrollments
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for flyway_schema_history
-- ----------------------------
DROP TABLE IF EXISTS "flyway_schema_history";
CREATE TABLE "flyway_schema_history" (
  "installed_rank" int4 NOT NULL,
  "version" varchar(50) COLLATE "pg_catalog"."default",
  "description" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "type" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "script" varchar(1000) COLLATE "pg_catalog"."default" NOT NULL,
  "checksum" int4,
  "installed_by" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "installed_on" timestamp(6) NOT NULL DEFAULT now(),
  "execution_time" int4 NOT NULL,
  "success" bool NOT NULL
)
;

-- ----------------------------
-- Records of flyway_schema_history
-- ----------------------------
BEGIN;
INSERT INTO "flyway_schema_history" ("installed_rank", "version", "description", "type", "script", "checksum", "installed_by", "installed_on", "execution_time", "success") VALUES (1, '1', 'create users', 'SQL', 'V1__create_users.sql', -1331645960, 'lms_user', '2026-05-18 14:05:09.193583', 37, 'f'), (2, '2', 'create refresh tokens', 'SQL', 'V2__create_refresh_tokens.sql', -1259870643, 'lms_user', '2026-05-18 14:05:09.251802', 35, 'f'), (3, '3', 'create courses', 'SQL', 'V3__create_courses.sql', -2128745597, 'lms_user', '2026-05-18 14:05:09.302385', 46, 'f'), (4, '4', 'create lessons', 'SQL', 'V4__create_lessons.sql', 1341873078, 'lms_user', '2026-05-18 14:05:09.36708', 31, 'f'), (5, '5', 'create lesson attachments', 'SQL', 'V5__create_lesson_attachments.sql', 1137842195, 'lms_user', '2026-05-18 14:05:09.412202', 18, 'f'), (6, '6', 'create enrollments', 'SQL', 'V6__create_enrollments.sql', 856680949, 'lms_user', '2026-05-18 14:05:09.443076', 29, 'f'), (7, '7', 'create payment proofs', 'SQL', 'V7__create_payment_proofs.sql', 1313128024, 'lms_user', '2026-05-18 14:05:09.484462', 22, 'f'), (8, '8', 'create lesson progress', 'SQL', 'V8__create_lesson_progress.sql', -1441179848, 'lms_user', '2026-05-18 14:05:09.520077', 40, 'f'), (9, '9', 'create system configs', 'SQL', 'V9__create_system_configs.sql', 1705785793, 'lms_user', '2026-05-18 14:05:09.572748', 24, 'f'), (10, '10', 'create bank info', 'SQL', 'V10__create_bank_info.sql', -1320830630, 'lms_user', '2026-05-18 14:05:09.609972', 13, 'f'), (11, '11', 'insert default configs', 'SQL', 'V11__insert_default_configs.sql', 1644208053, 'lms_user', '2026-05-18 14:05:09.636317', 4, 'f'), (12, '12', 'add deleted at to users', 'SQL', 'V12__add_deleted_at_to_users.sql', -1408446628, 'lms_user', '2026-05-18 14:05:09.651565', 8, 'f'), (13, '13', 'insert default admin', 'SQL', 'V13__insert_default_admin.sql', -945939351, 'lms_user', '2026-05-18 14:05:09.672041', 4, 'f'), (14, '14', 'update role default to users', 'SQL', 'V14__update_role_default_to_users.sql', 1666260884, 'lms_user', '2026-05-19 13:35:31.889719', 11, 'f'), (15, '15', 'add chapters', 'SQL', 'V15__add_chapters.sql', -1153420230, 'lms_user', '2026-05-25 15:42:31.055358', 217, 'f'), (16, '16', 'add description to chapters', 'SQL', 'V16__add_description_to_chapters.sql', 1507141243, 'lms_user', '2026-05-25 16:05:46.727335', 23, 'f'), (17, '17', 'restructure lessons add sections', 'SQL', 'V17__restructure_lessons_add_sections.sql', -1243924843, 'lms_user', '2026-05-27 10:34:19.073548', 181, 'f');
COMMIT;

-- ----------------------------
-- Table structure for lesson_attachments
-- ----------------------------
DROP TABLE IF EXISTS "lesson_attachments";
CREATE TABLE "lesson_attachments" (
  "id" int8 NOT NULL DEFAULT nextval('lesson_attachments_id_seq'::regclass),
  "lesson_id" int8 NOT NULL,
  "file_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "file_key" varchar(500) COLLATE "pg_catalog"."default" NOT NULL,
  "file_url" text COLLATE "pg_catalog"."default" NOT NULL,
  "file_type" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "file_size_bytes" int8 NOT NULL,
  "order_index" int4 NOT NULL DEFAULT 0,
  "created_at" timestamp(6) NOT NULL DEFAULT now()
)
;

-- ----------------------------
-- Records of lesson_attachments
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for lesson_progress
-- ----------------------------
DROP TABLE IF EXISTS "lesson_progress";
CREATE TABLE "lesson_progress" (
  "id" int8 NOT NULL DEFAULT nextval('lesson_progress_id_seq'::regclass),
  "student_id" int8 NOT NULL,
  "lesson_id" int8 NOT NULL,
  "course_id" int8 NOT NULL,
  "status" "public"."progress_status" NOT NULL DEFAULT 'NOT_STARTED'::progress_status,
  "video_watched_seconds" int4 NOT NULL DEFAULT 0,
  "video_max_watched_percent" float8 NOT NULL DEFAULT 0,
  "completed_at" timestamp(6),
  "last_accessed_at" timestamp(6),
  "created_at" timestamp(6) NOT NULL DEFAULT now(),
  "updated_at" timestamp(6) NOT NULL DEFAULT now()
)
;

-- ----------------------------
-- Records of lesson_progress
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for lessons
-- ----------------------------
DROP TABLE IF EXISTS "lessons";
CREATE TABLE "lessons" (
  "id" int8 NOT NULL DEFAULT nextval('lessons_id_seq'::regclass),
  "title" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "order_index" int4 NOT NULL DEFAULT 0,
  "created_at" timestamp(6) NOT NULL DEFAULT now(),
  "updated_at" timestamp(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamp(6),
  "chapter_id" int8 NOT NULL,
  "avatar_url" varchar(2000) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of lessons
-- ----------------------------
BEGIN;
INSERT INTO "lessons" ("id", "title", "description", "order_index", "created_at", "updated_at", "deleted_at", "chapter_id", "avatar_url") VALUES (1, 'Đêm nóng hơn, hiệu ứng đảo nhiệt, hàng triệu người lao động kiệt sức', 'Mỗi sáng, Jalaj Jha cảm thấy kiệt sức khi đi làm. Ban ngày, nhiệt độ có thể tăng lên hơn 45 độ C. Biến đổi khí hậu dự đoán tăng gấp 3 lần khả năng xảy ra nắng nóng trước mùa mưa.', 0, '2026-05-27 10:49:05.01648', '2026-05-27 10:49:05.01648', NULL, 3, 'http://localhost:8080/uploads/images/avatar/c57911165d9f4b7797e6740731125ec4.jpeg'), (2, 'Kickstart your career in artificial intelligence.', 'As Artificial intelligence (AI) and generative AI revolutionize our world, the demand for AI Software Developers with the right cutting-edge skills is soaring. This IBM AI Developer Professional Certificate will equip you with sought-after expertize in building AI-powered chatbots and apps and enable you to launch your AI career in just 6 months. No prior AI or programming experience required.', 0, '2026-05-27 16:33:09.032217', '2026-05-27 16:33:09.032732', NULL, 2, 'http://localhost:8080/uploads/images/avatar/6056094e22ce4df584e60638d9b3f0f2.png'), (3, 'Hướng dẫn nghề nghiệp dành cho nhà', 'Áp dụng các chiến lược kết nối và đánh giá danh sách việc làm để nhắm mục tiêu và theo đuổi các vị trí phát triển phần mềm một cách hiệu quả', 1, '2026-05-27 16:59:58.075278', '2026-05-27 16:59:58.075278', NULL, 3, 'http://localhost:8080/uploads/images/avatar/74b394cb5c3d4ad5a2f9204c953644a7.png');
COMMIT;

-- ----------------------------
-- Table structure for payment_proofs
-- ----------------------------
DROP TABLE IF EXISTS "payment_proofs";
CREATE TABLE "payment_proofs" (
  "id" int8 NOT NULL DEFAULT nextval('payment_proofs_id_seq'::regclass),
  "enrollment_id" int8 NOT NULL,
  "image_url" text COLLATE "pg_catalog"."default",
  "image_key" varchar(500) COLLATE "pg_catalog"."default",
  "note" text COLLATE "pg_catalog"."default",
  "created_at" timestamp(6) NOT NULL DEFAULT now(),
  "updated_at" timestamp(6) NOT NULL DEFAULT now()
)
;

-- ----------------------------
-- Records of payment_proofs
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for refresh_tokens
-- ----------------------------
DROP TABLE IF EXISTS "refresh_tokens";
CREATE TABLE "refresh_tokens" (
  "id" int8 NOT NULL DEFAULT nextval('refresh_tokens_id_seq'::regclass),
  "user_id" int8 NOT NULL,
  "token_hash" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "expires_at" timestamp(6) NOT NULL,
  "revoked_at" timestamp(6),
  "user_agent" varchar(500) COLLATE "pg_catalog"."default",
  "ip_address" varchar(45) COLLATE "pg_catalog"."default",
  "created_at" timestamp(6) NOT NULL DEFAULT now()
)
;

-- ----------------------------
-- Records of refresh_tokens
-- ----------------------------
BEGIN;
INSERT INTO "refresh_tokens" ("id", "user_id", "token_hash", "expires_at", "revoked_at", "user_agent", "ip_address", "created_at") VALUES (1, 1, '001a79e541b81ea3012d788cdbf7c397341ba1e2eddf9b4c2288b5767f084edb', '2026-06-17 15:07:18.89915', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-18 15:07:18.90902'), (2, 1, 'c5df0d8f67a1afee998769c72b93dda9020b981d4c2cd967523bfeaf05f2b761', '2026-06-17 15:07:44.388368', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-18 15:07:44.388898'), (3, 1, '987c8c7b8bb4063e058227316f45388a798ec0a6b9634528b7c8231a9db89bb3', '2026-06-17 15:22:50.091735', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-18 15:22:50.101384'), (4, 1, 'b45ed4ea955e56bcfd1454a1c5042d837a455f0ea05a244c6259098ca84340f2', '2026-06-18 10:16:29.942263', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-19 10:16:29.953601'), (5, 1, 'fe67b5acf092bd9b06f943bb7e175defe4b6ef73afb86d01aafdcb0f5c8f0a8d', '2026-06-18 13:20:49.562645', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-19 13:20:49.563689'), (6, 1, '79ec2739ea8f38dd2153dbe2a54838a7baf8d57a2cc3c996b8d7d3d2dc4bbb3d', '2026-06-18 13:37:38.419587', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-19 13:37:38.429767'), (7, 1, 'a53cb6ddcb35a3da61991979ca7453ef64f25984328000323d9cda85f715a005', '2026-06-18 14:41:57.666501', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-19 14:41:57.675319'), (8, 1, '438af1d52fc02d2681b0a88fb879f0cbc9017ab889de60ee85ef15b50a85207f', '2026-06-18 15:08:13.394606', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-19 15:08:13.395115'), (9, 1, '31e12d8f45f89494f44747df534a7513446e03e8aca59cd2330fe3cb02e52f42', '2026-06-18 15:36:32.395757', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-19 15:36:32.395757'), (10, 1, 'a07bfa26b5ec51c699345858ba9f1ee8f104f0b50434466936374098c3e9e9bd', '2026-06-18 16:20:12.941506', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-19 16:20:12.951287'), (11, 1, '37bcb01b7ba63c88247ac89a3090a5efdb9310eeea5835bfcdb002de9cd74f8b', '2026-06-18 16:20:33.158647', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-19 16:20:33.158646'), (12, 1, '1f38bda8249fa96bda872d40c2de51fc274c08e30f0aabd28b86c593156a23eb', '2026-06-18 16:21:18.336985', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-19 16:21:18.336985'), (13, 1, 'c7656e0cf710bdda03aa6c2b382a2ed42a1e487ea93411db7846f0df65439f6d', '2026-06-18 16:36:54.539262', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-19 16:36:54.549409'), (14, 1, '64f5b1c7c45fdf83333b8c0a59a553c86f98d644646431df5026dbf158e44dd2', '2026-06-18 16:57:46.169636', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-19 16:57:46.170642'), (15, 1, 'd04c3fc9714fd2cae6428006d316b6105031034f93877069456f1994f80cc1e4', '2026-06-18 16:58:58.818408', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-19 16:58:58.818924'), (16, 1, '2218c6d5f1bf3c1f9dfeda8e09a7536a2e10b73dad6588191b5ba444f10d5aca', '2026-06-18 17:04:08.74179', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-19 17:04:08.74232'), (17, 1, '49df534c6ce4b15dd030c01c7e615212186210b69df48bc94fc050cb39bb4878', '2026-06-18 17:27:35.236909', '2026-05-19 17:47:06.731381', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-19 17:27:35.237441'), (18, 1, '6e6585661517d4a72087c9d9c97ecdf3a09a903ec327c81dc3733d03a5a26185', '2026-06-18 17:47:06.733955', '2026-05-20 09:49:58.517023', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-19 17:47:06.736084'), (20, 1, '4e8ac91d4b3dd36f3a439958ad1c601591c256512d639b8ff2333a15ee57e494', '2026-06-19 09:55:04.073277', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-20 09:55:04.073276'), (19, 1, '00429a1846ed5d1404e61d940bf5b7a7f550dbcfe16e512a9a9ffdb24e5f7f0b', '2026-06-19 09:49:58.527402', '2026-05-20 10:05:49.69072', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-20 09:49:58.533924'), (21, 1, '96d9b606cd122d08aa2ed525880089f8e45ecdf5cf94e8aa95b342589a361d97', '2026-06-19 10:05:49.691246', '2026-05-20 10:21:11.237748', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-20 10:05:49.69282'), (23, 1, 'd610bb297b000aadfedcff5990b19f1d65d330173394029b7a3f6a6fee721faa', '2026-06-19 14:49:27.624325', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-20 14:49:27.628691'), (22, 1, '26fb7ba6e01208073f58bbe9824db66273ac70bab169648138d50399d567df6f', '2026-06-19 10:21:11.238275', '2026-05-20 14:49:27.616831', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-20 10:21:11.239304'), (24, 1, '9e1a09052ba822e0c635b2d71963a489c62a0b9cdad169e0932fcbc23b078fb4', '2026-06-19 15:31:54.217701', '2026-05-20 15:53:40.902668', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-20 15:31:54.218998'), (25, 1, 'f075f32922fa72cfc5463770f4d34f822e019895fd03c8bc6c1a0622203f15db', '2026-06-19 15:53:40.903675', '2026-05-20 16:08:45.588985', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-20 15:53:40.904673'), (26, 1, 'ffdb82c60bee7d05962ac438ce97a5898cd507a02869c6dec121cc25d34ef50f', '2026-06-19 16:08:45.589987', '2026-05-20 16:24:21.365431', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-20 16:08:45.59049'), (27, 1, '119f769f77b37129789aa450a2b7bc6247a5074a717f05bc74638216afe01221', '2026-06-19 16:24:21.365961', '2026-05-21 13:08:54.280775', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-20 16:24:21.366991'), (29, 1, '19d4693cd8a572c692f53c8c4f4a1b9e725e488092328105e1d89e384185d953', '2026-06-20 13:20:26.392541', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-21 13:20:26.393048'), (30, 1, 'aab0978653b1cbc7fc13603a734c6540d2638c11010cdffa37a91f1314edbd00', '2026-06-20 13:27:35.630305', '2026-05-21 15:48:42.997042', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-21 13:27:35.630304'), (28, 1, '51b0fd88115272d4f52944940854c58e5ce815f2b8b7e9ea88cfb014cb8e080f', '2026-06-20 13:08:54.290373', '2026-05-21 13:27:35.630305', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-21 13:08:54.301396'), (32, 1, 'a886212e00d745cbfbcf702957d8eacbace7a525a2a12d90a32c756d460af5f2', '2026-06-20 16:05:36.200792', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-21 16:05:36.202925'), (31, 1, 'b83a36135344ffb3d9933a20966988b5eeeebc73bf857cc78b33fffe4f5768b3', '2026-06-20 15:48:42.998076', '2026-05-21 16:05:36.199748', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-21 15:48:43.002779'), (33, 1, '1e105dce7ae5573e3c1883ca06774738982bdb7c028c285096bcdb9a3c9d8f64', '2026-06-20 16:05:46.292397', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-21 16:05:46.292913'), (34, 1, '21e00e6fef1ed99fec838976245b29083e6a8166843e0744e93225031d034dfb', '2026-06-20 16:06:15.638709', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-21 16:06:15.647847'), (35, 1, '86d584e6300b6dba40a06932748274917414f40fccec94297f98b5b8f1f2a460', '2026-06-20 16:06:26.276662', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-21 16:06:26.276662'), (36, 1, 'd4897f0a2d38ce07e01f7a7eff107b6ed0bfd73e61571517084d1406a0d686dd', '2026-06-20 16:06:42.881937', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-21 16:06:42.881936'), (37, 1, '3767c99046ea30c60947fb8e353ef6d560a9ce3e0e660639fca758619695b074', '2026-06-20 16:08:47.115389', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-21 16:08:47.115388'), (38, 1, 'c6d1be2302e94b10f3462a90771674073cc60963e0b66b07c48697b49512fa4b', '2026-06-20 16:10:20.659524', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-21 16:10:20.659524'), (39, 1, '515c1037116101cd7ad8f039929d413de85ce740159e9981e5a993c533564c96', '2026-06-20 16:11:50.373568', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-21 16:11:50.399937'), (40, 1, '30ae3acc8e35a0abd46a22a6fce47d4c9b47ba35c111b1e61474727117d5079d', '2026-06-20 16:13:04.193491', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-21 16:13:04.19402'), (41, 1, 'b9a255a4ee4fd629981806d0ae2944e8f56819c4c04e3e852e0c3f2d65d8419c', '2026-06-20 16:13:24.02903', '2026-05-21 16:31:28.950064', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-21 16:13:24.02903'), (42, 1, 'a783caffac24f92978bf526672272a5faf8a6bd2ad38dea5133d39c4d6bd6aed', '2026-06-20 16:31:28.952926', '2026-05-22 09:33:36.674955', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-21 16:31:28.952926'), (44, 1, '4d06f97b4ee0d533bf85f2d46af7c5d0379d9aa6f16d186cab3cbf131876463d', '2026-06-21 10:48:15.536818', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-22 10:48:15.537826'), (43, 1, 'c023359509b96a2836ad7d1a7a2b12c8b06530ac9c7243e3c00ea341774a3a20', '2026-06-21 09:33:36.685991', '2026-05-22 10:48:15.536818', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-22 09:33:36.693499'), (45, 1, '08cabf0b2fb1b6dab2c66e09f3d2337fcc82682affdf34d3625bb28ee230d32a', '2026-06-21 10:50:00.906218', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-22 10:50:00.906217'), (46, 1, 'c6bdd8aee97222c4a881c56d15d9c77dabf08c62fe618e846d0862e9bd160ddd', '2026-06-21 11:11:23.499677', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-22 11:11:23.501278'), (47, 1, '69230ad38b494e0c24332851b626cee0182d33e98f0f2e5c7c67a63999f061bb', '2026-06-21 11:11:31.064672', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-22 11:11:31.065273'), (48, 1, '00221359c4d82e5d552946d48b858990b8bc4a8c5dfc5e023a52e3a1a386e22a', '2026-06-21 11:12:23.526136', '2026-05-22 12:41:37.792118', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-22 11:12:23.526665'), (50, 1, '558a98aab9aae3448711cee981ec25b97e5d9d6021ec14011897e000aeecf19c', '2026-06-21 14:35:42.839007', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-22 14:35:42.842112'), (51, 1, '887a2c3cb8e22f5b58e4b5fd9e5ed0d03ee5c8d09ee3843200fa6f78d5d863e2', '2026-06-21 14:48:19.475297', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-22 14:48:19.475296'), (49, 1, '8459c4eaf10f9f2e2a369964c52704d0f8dbbf9e3ad4ab7aeec9e7122747f88c', '2026-06-21 12:41:37.798164', '2026-05-22 14:48:19.473879', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-22 12:41:37.808809'), (52, 1, 'ae5f4fa9e7eee9bf6838c1397ab47cb3d03dbf9645778b8daab77a5bda20f53d', '2026-06-21 14:53:44.876312', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-22 14:53:44.876835'), (53, 1, 'cc57452af8ab396c60549797d852862806aaad468ec693cf38b0c2c51beb888d', '2026-06-21 14:58:17.297314', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-22 14:58:17.297825'), (54, 1, '95781cd315cd7f3891407cc5d9db8680cc158abaf85990df3c28dcdf0bc42c61', '2026-06-21 15:10:58.229375', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-22 15:10:58.229374'), (55, 1, '2869a7b0a9f14f67b8ece38772e7422195ff061a0b65ba7611c0a13e551e85ed', '2026-06-21 15:16:24.120626', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-22 15:16:24.120625'), (56, 1, '230217233e1a8418dfef1755dc24a40790eee9dee8d255d620ecf21ecaf22c72', '2026-06-21 15:26:35.768081', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-22 15:26:35.768597'), (57, 1, '66dc1ce09e1122746094e4f191940a267419782afb26dd2a9fd11b545789713d', '2026-06-21 16:09:15.867348', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-22 16:09:15.868385'), (58, 1, '08d78f52f8f728408c397c663fb77c928601bbf1ef3d45a62608f363bd2c6a0c', '2026-06-21 16:12:58.661081', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-22 16:12:58.661614'), (59, 1, 'c0dcd7a75099872896b0b1648211dac23906110463082f3cdb289f2c8c8d4c0a', '2026-06-21 16:20:01.899909', '2026-05-22 17:22:54.662536', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-22 16:20:01.900435'), (61, 1, '66966e06024fe2dc6dd827f2d75b2d672f22af14986d5e96279caba563fe8f72', '2026-06-24 09:12:01.694215', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-25 09:12:01.701468'), (60, 1, '4555206f22216e8f80b3c8a9a38f9736a7ede32c03b5d5afa3a4235ccd6b6390', '2026-06-21 17:22:54.662536', '2026-05-25 09:12:01.685593', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-22 17:22:54.663535'), (62, 1, '8b751040421da167c3f014b8c036754a081f0993973151f0ed4862f918bd0b88', '2026-06-24 09:17:19.848027', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-25 09:17:19.848555'), (63, 1, '356910ce6d2977cec60ac846e059a157b15d42cf8ad51fe177e6de38c174314b', '2026-06-24 10:28:09.00374', '2026-05-25 11:27:48.657878', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-25 10:28:09.015789'), (64, 1, '585d84444ae398c3cbf72922aecb884505c368af8c2cdf4021f23fa8a2f08385', '2026-06-24 11:27:48.66306', '2026-05-25 11:43:53.244686', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-25 11:27:48.667377'), (66, 1, 'b57032c4a9eba487789fda19fdc48a6c2230bca5d5a3f24e1619e99c3e8564b5', '2026-06-24 13:38:41.82517', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-25 13:38:41.828968'), (67, 1, '79f077e2fa87bbe1a62dff46bfc81253d3834faed302469db9e13f04bb631442', '2026-06-24 14:58:19.250669', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-25 14:58:19.256764'), (65, 1, 'bc85d4ef43f3c15b19b1e202b8e7641574488acc5a0bb5a40baf12d3cf2db1af', '2026-06-24 11:43:53.245212', '2026-05-25 15:44:14.557101', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-25 11:43:53.24747'), (69, 1, '0c7052c399c2af4881c8018f8881611b05ea6d3252ee064e8faa61f0a8664f41', '2026-06-24 16:06:05.914122', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-25 16:06:05.922791'), (68, 1, '4273f704daf5e20a1a6ee559a77ea41f0c276a6e77fec26d55a03092538c5438', '2026-06-24 15:44:14.561367', '2026-05-25 16:06:05.907876', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-25 15:44:14.571047'), (71, 1, '4dffcc26868ea0d928245a8bfa1282461ec329ad10ce8a3dfd782971d2352625', '2026-06-24 16:22:54.131209', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-25 16:22:54.131724'), (70, 1, '604eed2467b89b56c8f09bc1b33e1b6a9e04a3d118f36060072ad1d03c9810f9', '2026-06-24 16:06:08.810234', '2026-05-25 16:22:54.130564', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-25 16:06:08.810233'), (72, 1, '421465415d3ae6dd630943d93b0baf82e0b17949d78b442e27e3005c5f93bae5', '2026-06-24 16:24:53.633341', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-25 16:24:53.63334'), (73, 1, '7db25bc2440334539d89cbce0f8d3b62c8494e0402ac825045a429c29dc252ae', '2026-06-24 17:12:51.926543', '2026-05-25 17:34:38.982077', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-25 17:12:51.938884'), (74, 1, 'fa9caa1d8e3eae7a29716c50c10eb60b5ab4f88c590f4903f42157f1f7f8d253', '2026-06-24 17:34:38.984659', '2026-05-25 17:54:27.226291', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-25 17:34:38.985489'), (75, 1, '62c36916cf5283dc5e20aea9c93d1e8888afb1ac2fb82b07ba3d3989592b75ec', '2026-06-24 17:54:27.227305', '2026-05-26 09:34:40.120707', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-25 17:54:27.228414'), (76, 1, '4ab7cc8b99755af01af99ec89f256fb0a29dfa4750b260d1c2f564c979c3fa35', '2026-06-25 09:34:40.128636', '2026-05-26 10:14:56.968928', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-26 09:34:40.134026'), (77, 1, '23e02567d843a43252c9b292ca8455f972e570cd647111e15dff4ad152824a5a', '2026-06-25 10:14:56.969448', '2026-05-26 10:37:15.203887', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-26 10:14:56.969975'), (78, 1, '591cfa68d924391155d9a9b081a613bd007ae80a50104c6582f73073858afc36', '2026-06-25 10:37:15.204399', '2026-05-26 10:55:44.571379', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-26 10:37:15.204934'), (79, 1, '5de6dba4bb7489361b91f20a40b225ac8438aa5616328174a3fd73eb83dca82b', '2026-06-25 10:55:44.571379', '2026-05-26 12:01:39.234536', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-26 10:55:44.571891'), (80, 1, 'ebdc4c2c5c354a379c2ba868740440774757ba4f276ac7ec452b598fc1b92e15', '2026-06-25 12:01:39.23505', '2026-05-26 13:17:04.684511', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-26 12:01:39.238151'), (82, 1, '6e123984d39907ad40392a0ddcd8fc81661ac1aee34527f7efd6203fadaee5d9', '2026-06-25 14:03:09.246274', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-26 14:03:09.247796'), (81, 1, '2f1dea55d5c83a1088461ae311dddaf43b68afebd5eaaa01603bceef2899c443', '2026-06-25 13:17:04.685552', '2026-05-26 14:03:09.246274', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-26 13:17:04.688189'), (83, 1, '22db3cc2bc6c60e4d070df1c016d8abc67e4d671ba59b834f1a7b9b0663d8e33', '2026-06-25 14:25:38.388273', '2026-05-26 14:45:22.017124', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-26 14:25:38.389314'), (84, 1, '83d6bd9a051109d036ca4854500b81dfc990ed17ce0e50f2a728716f30b31f12', '2026-06-25 14:45:22.017124', '2026-05-26 15:02:08.47793', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-26 14:45:22.019183'), (85, 1, 'be4c754747d7bb6341754a2edd164925a93e636d122f9a9bea3090ff53b6c4d8', '2026-06-25 15:02:08.478488', '2026-05-26 15:18:31.089903', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-26 15:02:08.479491'), (87, 1, '7a0ebb1b84081c0a0020993fcc699bff8337b87aad3aaf3fcb9ffebfc946c368', '2026-06-25 15:40:23.138257', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-26 15:40:23.138257'), (86, 1, '24046383c03612abf722e9ed741f02bff430fd11e0fd1825ba1387b56dc18037', '2026-06-25 15:18:31.090416', '2026-05-26 15:40:23.137256', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-26 15:18:31.09198'), (88, 1, '0f0edf7a71a5cc3cd01ae9276862af93e7d461787f145330eb57f4460f4aa943', '2026-06-25 15:40:46.001924', '2026-05-26 16:19:11.27879', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-26 15:40:46.002929'), (89, 1, '9a3777a1c63be74b438e402b0a7eb9a5c38ab45231ebeb3f8c7b7af05ce8e9f4', '2026-06-25 16:19:11.279308', '2026-05-26 16:40:46.939773', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-26 16:19:11.280312'), (90, 1, '71ac8f325ecadb669d0ca48dd8705e3767d5fb1db720f143005ac1d29fff5807', '2026-06-25 16:40:46.939773', '2026-05-26 16:58:59.290135', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-26 16:40:46.94081'), (91, 1, 'b9778bad3b82cd52645072722d48a99608cb4aea8b7b0afaa39f1b928a459c3b', '2026-06-25 16:58:59.291173', '2026-05-26 17:15:43.564158', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-26 16:58:59.29218'), (92, 1, '5d6d3c981a0559d68e06e1ab13e0f564e46bd5a2738c1a184cd425c261cf2988', '2026-06-25 17:15:43.564158', '2026-05-26 17:37:46.735573', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-26 17:15:43.565179'), (93, 1, 'c52f931167757f8ad5dbf0ef0365b4384bd3f5488159c8a2bdd1cdad8bed4fce', '2026-06-25 17:37:46.736578', '2026-05-26 18:16:24.26345', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-26 17:37:46.73758'), (94, 1, '46a62d70a98a70c07c0fa439785f465d761dd5350a7d60a392b101760480763b', '2026-06-25 18:16:24.26345', '2026-05-27 09:27:15.081906', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-26 18:16:24.264613'), (128, 1, '39c8728e0d346c090f905cdc90bf0ee2a5dfa64a8db9d845bc02dee3c85c58d4', '2026-06-26 10:37:46.602651', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-27 10:37:46.60776'), (127, 1, 'fb5b9d665bce4149c9fb8ccb3a84944d3ef570e02c56d03a306ffbd143266695', '2026-06-26 09:27:15.08758', '2026-05-27 10:37:46.592935', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-27 09:27:15.092255'), (129, 1, '32a41d69f70ca062074515c24ca3faba8316c4e89368a2bd037341421c7c4f77', '2026-06-26 10:37:58.469889', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-27 10:37:58.469888'), (131, 1, '5a67de24d1f932b6dd5d0066efcdf3bfd92ca7cca16f37e20ce449b866b703c6', '2026-06-26 11:35:32.091873', '2026-05-27 11:54:32.925967', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-27 11:35:32.094081'), (130, 1, '0dd0ad32cfc8515b04f59773e683602ebe3be0be0b04e3f1a7134879d2317c8e', '2026-06-26 10:44:08.335752', '2026-05-27 11:35:32.089712', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-27 10:44:08.336337'), (132, 1, '8015a82a37c99c7cf6e4d75735aee0eedb1e60bdd8bd5ac5ec91724600aaf688', '2026-06-26 11:54:32.927007', '2026-05-27 13:13:34.30281', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-27 11:54:32.928597'), (134, 1, '54c21926be1932139c3e4cec41396fa8234c3e4eef2f8f91f23fa899af8a8dd1', '2026-06-26 16:11:58.837283', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-27 16:11:58.8438'), (133, 1, 'd5b7329fe9fe1bb96b3d01a24cd42540a320016a118eef04be72c8b42511d2a5', '2026-06-26 13:13:34.30281', '2026-05-27 16:11:58.829762', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-27 13:13:34.304327'), (135, 1, '80acecfcafb0c6decd834fc2624b98257d68a497245f2b29cf9353e4cfd763a2', '2026-06-26 16:32:30.087263', '2026-05-27 16:56:18.015683', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-27 16:32:30.088334'), (137, 1, 'c93bf1a8075444931e494a7ddc241388e26a39fea1cda69404663c30617c3ca7', '2026-06-26 17:11:47.023005', NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-27 17:11:47.023005'), (136, 1, '837ce5a33af48d5cf2251d8386ce2114451e40c996676a497208d5504fe757f6', '2026-06-26 16:56:18.016213', '2026-05-27 17:11:47.022485', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '0:0:0:0:0:0:0:1', '2026-05-27 16:56:18.016212');
COMMIT;

-- ----------------------------
-- Table structure for sections
-- ----------------------------
DROP TABLE IF EXISTS "sections";
CREATE TABLE "sections" (
  "id" int8 NOT NULL DEFAULT nextval('sections_id_seq'::regclass),
  "lesson_id" int8 NOT NULL,
  "title" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "type" "public"."section_type" NOT NULL,
  "status" "public"."section_status" NOT NULL DEFAULT 'PUBLISHED'::section_status,
  "video_url" text COLLATE "pg_catalog"."default",
  "text_content" text COLLATE "pg_catalog"."default",
  "order_index" int4 NOT NULL DEFAULT 0,
  "created_at" timestamp(6) NOT NULL DEFAULT now(),
  "updated_at" timestamp(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamp(6)
)
;

-- ----------------------------
-- Records of sections
-- ----------------------------
BEGIN;
INSERT INTO "sections" ("id", "lesson_id", "title", "description", "type", "status", "video_url", "text_content", "order_index", "created_at", "updated_at", "deleted_at") VALUES (1, 1, 'Foundations of Data Science', 'Understand common careers and industries that use advanced data analytics

Investigate the impact data analysis can have on decision-making', 'TEXT', 'PUBLISHED', NULL, '<h2><strong>Xây dựng chuyên môn Data Analysis của bạn</strong></h2><p>Khóa học này là một phần của <a target="_blank" rel="noopener noreferrer" class="cds-119 cds-113 cds-115 css-17di3rg cds-142" href="https://www.coursera.org/professional-certificates/google-advanced-data-analytics"><strong>Chứng chỉ chuyên môn về Google Advanced Data Analytics</strong></a></p><p>Khi bạn đăng ký khóa học này, bạn cũng sẽ được đăng ký vào Chứng chỉ chuyên môn này.</p><ul><li><p>Tìm hiểu các khái niệm mới từ các chuyên gia trong ngành</p></li><li><p>Lĩnh hội được kiến thức cơ bản về một chủ đề hoặc công cụ</p></li><li><p>Phát triển kỹ năng liên quan đến công việc thông qua các dự án thực tiễn</p></li><li><p>Nhận chứng chỉ nghề nghiệp có thể chia sẻ từ Google</p></li></ul><h2><strong>Có là 5 mô-đun trong khóa học này</strong></h2><p>This is the first course in the Google Advanced Data Analytics Certificate, which will help develop the skills needed to apply for more advanced data professional roles, such as an entry-level data scientist or advanced-level data analyst. Data professionals analyze data to help businesses make better decisions. To do this, they use powerful techniques like data storytelling, statistics, and machine learning. In this course, you’ll begin your learning journey by exploring the role of data professionals in the workplace. You’ll also learn about the project workflow PACE (Plan, Analyze, Construct, Execute) and how it can help you organize data projects.</p><p>Google employees who currently work in the field will guide you through this course by providing hands-on activities that simulate relevant tasks, sharing examples from their day-to-day work, and helping you enhance your data analytics skills to prepare for your career. <br><br>Learners who complete the eight courses in this program will have the skills needed to apply for data science and advanced data analytics jobs. This certificate assumes prior knowledge of foundational analytical principles, skills, and tools covered in the Google Data Analytics Certificate.  <br><br>By the end of this course, you will:<br>-Describe the functions of data analytics and data science within an organization<br>-Identify tools used by data professionals <br>-Explore the value of data-based roles in organizations <br>-Investigate career opportunities for a data professional <br>-Explain a data project workflow <br>-Develop effective communication skills</p><p></p>', 1, '2026-05-27 11:54:32.987349', '2026-05-27 11:54:32.987349', NULL), (2, 1, 'Chứng chỉ chuyên môn về IBM AI', 'Job-ready AI skills in just 6 months, plus practical experience and an industry-recognized certification employers are actively looking for', 'TEXT', 'PUBLISHED', NULL, '<h2><strong>Chứng chỉ Chuyên môn - 10 chuỗi khóa học</strong></h2><p>As Artificial intelligence (AI) and generative AI revolutionize our world, the demand for AI Software Developers with the right cutting-edge skills is soaring. This IBM AI Developer Professional Certificate will equip you with sought-after expertize in building AI-powered chatbots and apps and enable you to <strong>launch your AI career in just 6 months</strong>. No prior AI or programming experience required.</p><p>AI Developers are prized software engineers who design, develop, and implement AI and genAI powered apps And virtual assistants. They specialize in applying their programming expertize and integrating pre-built AI models and APIs to create intelligent software and solutions.</p><p>During this self-paced Professional Certificate program, you’ll <strong>master the fundamentals of software engineering, AI, generative AI</strong>, prompt engineering, HTML, JavaScript and Python programming. And through hands-on labs and projects, you’ll gain practical experience in building AI apps you can talk about in interviews.</p><p>Once you’ve successfully completed the program, you’ll have a Professional Certificate from Coursera and a <strong>digital badge from IBM</strong> that <strong>showcase your AI proficiency</strong>. And you’ll have access to career assistance, job search, and interview preparation resources.</p><p>Enroll in this IBM AI Developer Professional Certificate today and <strong>transform your career opportunities in just 6 months</strong>.</p><p><strong>Dự án Học tập thực tiễn</strong></p><p>Throughout this Professional Certificate, you will complete hands-on labs and projects that help you practice and apply your newly acquired generative AI and programming skills.</p><p>Examples of the projects you will complete include:</p><ul><li><p>Develop a portfolio website using HTML, CSS and JavaScript.</p></li><li><p>Build a sentiment analysis application using Python, Flask and embedded AI libraries.</p></li><li><p>Give meaningful captions to your photos using Generative AI.</p></li><li><p>Create ChatGPT-like website with open source LLMs.</p></li><li><p>Create a voice assistant with OpenAI''s GPT APIs and IBM Watson libraries.</p></li><li><p></p></li></ul><p><br></p>', 2, '2026-05-27 16:58:34.103834', '2026-05-27 16:58:34.103834', NULL), (3, 3, 'Nhận chứng chỉ nghề nghiệp', 'Có thể tham gia các khóa học theo tốc độ và nhịp điệu của riêng tôi là một trải nghiệm tuyệt vời. Tôi có thể học bất cứ khi nào phù hợp với lịch trình và tâm trạng của tôi.', 'TEXT', 'DRAFT', NULL, '<h2><strong>Xây dựng chuyên môn trong lĩnh vực chuyên nghiệp của bạn</strong></h2><p>Khóa học này có sẵn như một phần của</p><p>Khi bạn đăng ký khóa học này, bạn cũng sẽ được yêu cầu chọn một chương trình cụ thể.</p><ul><li><p>Tìm hiểu các khái niệm mới từ các chuyên gia trong ngành</p></li><li><p>Lĩnh hội được kiến thức cơ bản về một chủ đề hoặc công cụ</p></li><li><p>Phát triển kỹ năng liên quan đến công việc thông qua các dự án thực tiễn</p></li><li><p>Nhận chứng chỉ nghề nghiệp có thể chia sẻ từ IBM</p></li></ul><h2><strong>Có là 3 mô-đun trong khóa học này</strong></h2><p>Các chuyên gia kỹ thuật phần mềm đang có nhu cầu cao trên toàn thế giới và xu hướng này không cho thấy dấu hiệu chậm lại. Có rất nhiều công việc tuyệt vời, nhưng cũng có rất nhiều ứng viên tuyệt vời. Làm thế nào bạn có thể có được lợi thế trong một lĩnh vực cạnh tranh như vậy?</p><p>Khóa học này sẽ chuẩn bị cho bạn tham gia thị trường việc làm như một ứng cử viên mạnh mẽ cho một vị trí kỹ sư phần mềm. Nó cung cấp các kỹ thuật thực tế để tạo ra các tài liệu tìm kiếm việc làm cần thiết như sơ yếu lý lịch và danh mục đầu tư, cùng với các công cụ hỗ trợ như thư xin việc và quảng cáo thang máy. Bạn cũng sẽ học cách tiến hành nghiên cứu công ty và ngành công nghiệp, xác định vai trò phù hợp với sở thích và mức độ kỹ năng của bạn và xây dựng chiến lược tìm kiếm việc làm được nhắm mục tiêu. <br><br>Bạn sẽ nhận được hướng dẫn về cách kết nối mạng cả trực tuyến và ngoại tuyến, đánh giá danh sách việc làm và gửi đơn đăng ký chất lượng cao. Khóa học cũng sẽ hướng dẫn bạn từng giai đoạn của quá trình phỏng vấn, từ sàng lọc ban đầu đến thử thách mã hóa, phỏng vấn vòng hai và cuộc trò chuyện cuối cùng với các nhóm tuyển dụng. <br><br> Nó không dừng lại ở đó. Bạn sẽ nhận được các mẹo bên trong về cách theo dõi chuyên nghiệp sau một cuộc phỏng vấn và suy ngẫm về hiệu suất của bạn để liên tục cải thiện. Bạn cũng sẽ có được cái nhìn sâu sắc về trách nhiệm và nhiệm vụ thường xuyên của các nhà phát triển phần mềm, khám phá con đường sự nghiệp và học hỏi từ các chuyên gia đã điều hướng thành công ngành công nghệ. <br><br>Trong suốt khóa học, các chuyên gia phần mềm dày dạn kinh nghiệm chia sẻ hành trình nghề nghiệp và lời khuyên của riêng họ, đưa ra các chiến lược thiết thực để kết nối mạng, chuẩn bị cho các cuộc phỏng vấn và nổi bật trong các đánh giá kỹ thuật. <br><br>Khóa học này sẽ chuẩn bị cho người học các vai trò với nhiều chức danh khác nhau, bao gồm Kỹ sư phần mềm, Nhà phát triển phần mềm, Nhà phát triển ứng dụng, Nhà phát triển Full-Stack, Nhà phát triển Front-End, Nhà phát triển Back-End, Kỹ sư DevOps và Nhà phát triển ứng dụng di động.</p><p><strong>Đọc ít hơn</strong></p>', 1, '2026-05-27 17:00:37.598556', '2026-05-27 17:05:26.43075', NULL), (4, 3, 'Vua Champa Đã 4 Lần Đốt Thăng Long Và Đẩy Đại Việt Đến Bờ Diệt Vong  Tiền Đâu? 4,96 N người đăng ký  Đăng ký', 'Ba lần chiến thắng đế quốc Mông - Nguyên hùng mạnh, nhưng Đại Việt lại suýt chút nữa bị xóa sổ bởi một vương quốc nhỏ phương Nam. Vua Champa đã 4 lần đốt Thăng Long và đẩy Đại Việt đến bờ diệt vong — câu chuyện lịch sử đầy máu và nước mắt về Chế Bồng Nga, người đàn ông khiến triều Trần kinh hoàng điên đảo suốt 19 năm ròng rã. Hãy cùng lật mở lại những góc khuất chưa từng được kể trong sách giáo khoa về cuộc đối đầu nghẹt thở định đoạt vận mệnh của cả hai dân tộc.', 'VIDEO', 'DRAFT', 'https://www.youtube.com/watch?v=eb9EGFhhIXQ&t=359s', NULL, 2, '2026-05-27 17:26:03.590113', '2026-05-27 17:26:03.590113', NULL);
COMMIT;

-- ----------------------------
-- Table structure for system_configs
-- ----------------------------
DROP TABLE IF EXISTS "system_configs";
CREATE TABLE "system_configs" (
  "id" int4 NOT NULL DEFAULT nextval('system_configs_id_seq'::regclass),
  "key" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "value" text COLLATE "pg_catalog"."default" NOT NULL,
  "description" varchar(500) COLLATE "pg_catalog"."default",
  "updated_by" int8,
  "updated_at" timestamp(6) NOT NULL DEFAULT now()
)
;

-- ----------------------------
-- Records of system_configs
-- ----------------------------
BEGIN;
INSERT INTO "system_configs" ("id", "key", "value", "description", "updated_by", "updated_at") VALUES (1, 'COMPLETION_MODE', 'OPEN', 'Chế độ hoàn thành bài học: OPEN = mở là xong, VIDEO_50 = phải xem 50% video', NULL, '2026-05-18 14:05:09.639747'), (2, 'MAX_VIDEO_SIZE_MB', '2048', 'Giới hạn kích thước file video upload (MB)', NULL, '2026-05-18 14:05:09.639747'), (3, 'MAX_DOCUMENT_SIZE_MB', '50', 'Giới hạn kích thước file tài liệu upload (MB)', NULL, '2026-05-18 14:05:09.639747'), (4, 'ALLOWED_VIDEO_TYPES', 'mp4,mov,webm,avi', 'Định dạng video được phép upload', NULL, '2026-05-18 14:05:09.639747'), (5, 'ALLOWED_DOC_TYPES', 'pdf,docx,xlsx,pptx,txt', 'Định dạng tài liệu được phép upload', NULL, '2026-05-18 14:05:09.639747');
COMMIT;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS "users";
CREATE TABLE "users" (
  "id" int8 NOT NULL DEFAULT nextval('users_id_seq'::regclass),
  "email" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "password_hash" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "full_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "avatar_url" text COLLATE "pg_catalog"."default",
  "phone" varchar(20) COLLATE "pg_catalog"."default",
  "role" "public"."user_role" NOT NULL DEFAULT 'STUDENT'::user_role,
  "status" "public"."user_status" NOT NULL DEFAULT 'ACTIVE'::user_status,
  "reset_token" varchar(255) COLLATE "pg_catalog"."default",
  "reset_token_expires_at" timestamp(6),
  "created_at" timestamp(6) NOT NULL DEFAULT now(),
  "updated_at" timestamp(6) NOT NULL DEFAULT now(),
  "deleted_at" timestamp(6)
)
;

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO "users" ("id", "email", "password_hash", "full_name", "avatar_url", "phone", "role", "status", "reset_token", "reset_token_expires_at", "created_at", "updated_at", "deleted_at") VALUES (1, 'admin@lms.com', '$2a$10$8BgEqebxjPQ2J1hkmtRjwOzJZWuxlLVScJKYWijyo3ZvsjxnrX7Pq', 'System Administrator', 'https://codedthemes.com/demos/admin-templates/datta-able/react/default/assets/avatar-1-aH-LGLvV.png', NULL, 'ADMIN', 'ACTIVE', NULL, NULL, '2026-05-18 14:05:09.676301', '2026-05-18 14:05:09.676301', NULL);
COMMIT;

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "bank_info_id_seq"
OWNED BY "bank_info"."id";
SELECT setval('"bank_info_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "chapters_id_seq"
OWNED BY "chapters"."id";
SELECT setval('"chapters_id_seq"', 4, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "courses_id_seq"
OWNED BY "courses"."id";
SELECT setval('"courses_id_seq"', 20, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "enrollments_id_seq"
OWNED BY "enrollments"."id";
SELECT setval('"enrollments_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "lesson_attachments_id_seq"
OWNED BY "lesson_attachments"."id";
SELECT setval('"lesson_attachments_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "lesson_progress_id_seq"
OWNED BY "lesson_progress"."id";
SELECT setval('"lesson_progress_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "lessons_id_seq"
OWNED BY "lessons"."id";
SELECT setval('"lessons_id_seq"', 3, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "payment_proofs_id_seq"
OWNED BY "payment_proofs"."id";
SELECT setval('"payment_proofs_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "refresh_tokens_id_seq"
OWNED BY "refresh_tokens"."id";
SELECT setval('"refresh_tokens_id_seq"', 137, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "sections_id_seq"
OWNED BY "sections"."id";
SELECT setval('"sections_id_seq"', 4, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "system_configs_id_seq"
OWNED BY "system_configs"."id";
SELECT setval('"system_configs_id_seq"', 5, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "users_id_seq"
OWNED BY "users"."id";
SELECT setval('"users_id_seq"', 1, true);

-- ----------------------------
-- Primary Key structure for table bank_info
-- ----------------------------
ALTER TABLE "bank_info" ADD CONSTRAINT "bank_info_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table chapters
-- ----------------------------
CREATE INDEX "idx_chapters_course_id" ON "chapters" USING btree (
  "course_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_chapters_deleted_at" ON "chapters" USING btree (
  "deleted_at" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table chapters
-- ----------------------------
ALTER TABLE "chapters" ADD CONSTRAINT "chapters_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table courses
-- ----------------------------
CREATE INDEX "idx_courses_deleted_at" ON "courses" USING btree (
  "deleted_at" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_courses_slug" ON "courses" USING btree (
  "slug" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_courses_status" ON "courses" USING btree (
  "status" "pg_catalog"."enum_ops" ASC NULLS LAST
);
CREATE INDEX "idx_courses_teacher_id" ON "courses" USING btree (
  "teacher_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table courses
-- ----------------------------
ALTER TABLE "courses" ADD CONSTRAINT "uq_courses_slug" UNIQUE ("slug");

-- ----------------------------
-- Primary Key structure for table courses
-- ----------------------------
ALTER TABLE "courses" ADD CONSTRAINT "courses_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table enrollments
-- ----------------------------
CREATE INDEX "idx_enrollments_course_id" ON "enrollments" USING btree (
  "course_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_enrollments_status" ON "enrollments" USING btree (
  "status" "pg_catalog"."enum_ops" ASC NULLS LAST
);
CREATE INDEX "idx_enrollments_student_id" ON "enrollments" USING btree (
  "student_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table enrollments
-- ----------------------------
ALTER TABLE "enrollments" ADD CONSTRAINT "enrollments_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table flyway_schema_history
-- ----------------------------
CREATE INDEX "flyway_schema_history_s_idx" ON "flyway_schema_history" USING btree (
  "success" "pg_catalog"."bool_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table flyway_schema_history
-- ----------------------------
ALTER TABLE "flyway_schema_history" ADD CONSTRAINT "flyway_schema_history_pk" PRIMARY KEY ("installed_rank");

-- ----------------------------
-- Indexes structure for table lesson_attachments
-- ----------------------------
CREATE INDEX "idx_lesson_attachments_lesson_id" ON "lesson_attachments" USING btree (
  "lesson_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table lesson_attachments
-- ----------------------------
ALTER TABLE "lesson_attachments" ADD CONSTRAINT "lesson_attachments_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table lesson_progress
-- ----------------------------
CREATE INDEX "idx_lesson_progress_lesson_id" ON "lesson_progress" USING btree (
  "lesson_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_lesson_progress_status" ON "lesson_progress" USING btree (
  "status" "pg_catalog"."enum_ops" ASC NULLS LAST
);
CREATE INDEX "idx_lesson_progress_student_course" ON "lesson_progress" USING btree (
  "student_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "course_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table lesson_progress
-- ----------------------------
ALTER TABLE "lesson_progress" ADD CONSTRAINT "uq_lesson_progress_student_lesson" UNIQUE ("student_id", "lesson_id");

-- ----------------------------
-- Primary Key structure for table lesson_progress
-- ----------------------------
ALTER TABLE "lesson_progress" ADD CONSTRAINT "lesson_progress_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table lessons
-- ----------------------------
CREATE INDEX "idx_lessons_chapter_id" ON "lessons" USING btree (
  "chapter_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_lessons_chapter_order" ON "lessons" USING btree (
  "chapter_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "order_index" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_lessons_deleted_at" ON "lessons" USING btree (
  "deleted_at" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table lessons
-- ----------------------------
ALTER TABLE "lessons" ADD CONSTRAINT "lessons_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table payment_proofs
-- ----------------------------
CREATE INDEX "idx_payment_proofs_enrollment_id" ON "payment_proofs" USING btree (
  "enrollment_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table payment_proofs
-- ----------------------------
ALTER TABLE "payment_proofs" ADD CONSTRAINT "uq_payment_proofs_enrollment" UNIQUE ("enrollment_id");

-- ----------------------------
-- Primary Key structure for table payment_proofs
-- ----------------------------
ALTER TABLE "payment_proofs" ADD CONSTRAINT "payment_proofs_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table refresh_tokens
-- ----------------------------
CREATE INDEX "idx_refresh_tokens_expires_at" ON "refresh_tokens" USING btree (
  "expires_at" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_refresh_tokens_hash" ON "refresh_tokens" USING btree (
  "token_hash" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_refresh_tokens_user_id" ON "refresh_tokens" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table refresh_tokens
-- ----------------------------
ALTER TABLE "refresh_tokens" ADD CONSTRAINT "uq_refresh_tokens_hash" UNIQUE ("token_hash");

-- ----------------------------
-- Primary Key structure for table refresh_tokens
-- ----------------------------
ALTER TABLE "refresh_tokens" ADD CONSTRAINT "refresh_tokens_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table sections
-- ----------------------------
CREATE INDEX "idx_sections_deleted_at" ON "sections" USING btree (
  "deleted_at" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_sections_lesson_id" ON "sections" USING btree (
  "lesson_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_sections_lesson_order" ON "sections" USING btree (
  "lesson_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "order_index" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table sections
-- ----------------------------
ALTER TABLE "sections" ADD CONSTRAINT "sections_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table system_configs
-- ----------------------------
CREATE INDEX "idx_system_configs_key" ON "system_configs" USING btree (
  "key" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table system_configs
-- ----------------------------
ALTER TABLE "system_configs" ADD CONSTRAINT "uq_system_configs_key" UNIQUE ("key");

-- ----------------------------
-- Primary Key structure for table system_configs
-- ----------------------------
ALTER TABLE "system_configs" ADD CONSTRAINT "system_configs_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table users
-- ----------------------------
CREATE INDEX "idx_users_deleted_at" ON "users" USING btree (
  "deleted_at" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_users_email" ON "users" USING btree (
  "email" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_users_role" ON "users" USING btree (
  "role" "pg_catalog"."enum_ops" ASC NULLS LAST
);
CREATE INDEX "idx_users_status" ON "users" USING btree (
  "status" "pg_catalog"."enum_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table users
-- ----------------------------
ALTER TABLE "users" ADD CONSTRAINT "uq_users_email" UNIQUE ("email");

-- ----------------------------
-- Primary Key structure for table users
-- ----------------------------
ALTER TABLE "users" ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Foreign Keys structure for table bank_info
-- ----------------------------
ALTER TABLE "bank_info" ADD CONSTRAINT "bank_info_updated_by_fkey" FOREIGN KEY ("updated_by") REFERENCES "users" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table chapters
-- ----------------------------
ALTER TABLE "chapters" ADD CONSTRAINT "chapters_course_id_fkey" FOREIGN KEY ("course_id") REFERENCES "courses" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table courses
-- ----------------------------
ALTER TABLE "courses" ADD CONSTRAINT "courses_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "users" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "courses" ADD CONSTRAINT "courses_teacher_id_fkey" FOREIGN KEY ("teacher_id") REFERENCES "users" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table enrollments
-- ----------------------------
ALTER TABLE "enrollments" ADD CONSTRAINT "enrollments_course_id_fkey" FOREIGN KEY ("course_id") REFERENCES "courses" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "enrollments" ADD CONSTRAINT "enrollments_reviewed_by_fkey" FOREIGN KEY ("reviewed_by") REFERENCES "users" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "enrollments" ADD CONSTRAINT "enrollments_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "users" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table lesson_attachments
-- ----------------------------
ALTER TABLE "lesson_attachments" ADD CONSTRAINT "lesson_attachments_lesson_id_fkey" FOREIGN KEY ("lesson_id") REFERENCES "lessons" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table lesson_progress
-- ----------------------------
ALTER TABLE "lesson_progress" ADD CONSTRAINT "lesson_progress_course_id_fkey" FOREIGN KEY ("course_id") REFERENCES "courses" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "lesson_progress" ADD CONSTRAINT "lesson_progress_lesson_id_fkey" FOREIGN KEY ("lesson_id") REFERENCES "lessons" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "lesson_progress" ADD CONSTRAINT "lesson_progress_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "users" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table lessons
-- ----------------------------
ALTER TABLE "lessons" ADD CONSTRAINT "lessons_chapter_id_fkey" FOREIGN KEY ("chapter_id") REFERENCES "chapters" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table payment_proofs
-- ----------------------------
ALTER TABLE "payment_proofs" ADD CONSTRAINT "payment_proofs_enrollment_id_fkey" FOREIGN KEY ("enrollment_id") REFERENCES "enrollments" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table refresh_tokens
-- ----------------------------
ALTER TABLE "refresh_tokens" ADD CONSTRAINT "refresh_tokens_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table sections
-- ----------------------------
ALTER TABLE "sections" ADD CONSTRAINT "sections_lesson_id_fkey" FOREIGN KEY ("lesson_id") REFERENCES "lessons" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table system_configs
-- ----------------------------
ALTER TABLE "system_configs" ADD CONSTRAINT "system_configs_updated_by_fkey" FOREIGN KEY ("updated_by") REFERENCES "users" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
