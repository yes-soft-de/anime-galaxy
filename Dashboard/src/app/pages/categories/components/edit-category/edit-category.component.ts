import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { CategoryService } from '../../services/category.service';
import { ActivatedRoute, ParamMap, Router } from '@angular/router';
import { ListCategory } from '../../entity/list-category';
import { ToastrService } from 'ngx-toastr';
import { ImageSnippet } from '../../entity/image-snippet';
import { ListCategoryResponse } from '../../entity/list-category-response';
import { CategoryResponse } from '../../entity/category-response';

@Component({
  selector: 'app-edit-category',
  templateUrl: './edit-category.component.html',
  styleUrls: ['./edit-category.component.scss']
})
export class EditCategoryComponent implements OnInit {
  categoryId: number;
  isSubmitted = false;
  uploadForm: FormGroup;
  categoryData: ListCategory;
  uploadButtonValue = 'Upload';
  imageName = 'Leave it if you don\'t want to change image';
  fileSelected = false;
  imageUrl: string;
  imagePathReady = true;
  submitButtonValue = 'Update Category';
  selectedFile: ImageSnippet;

  constructor(private categoryService: CategoryService,
              private toaster: ToastrService,
              private formBuilder: FormBuilder,
              private router: Router,
              private activatedRoute: ActivatedRoute) {
  }

  ngOnInit() {
    this.activatedRoute.paramMap.subscribe((param: ParamMap) => {
      this.categoryId = +param.get('id');
    });

    this.categoryService.getCategory(this.categoryId).subscribe(
      (categoryResponse: CategoryResponse) => {
        this.categoryData = categoryResponse.Data;
        this.updateFormValues();
      }, error => console.log(error)
    );

    // Fetch Form Data
    this.uploadForm = this.formBuilder.group({
      name: ['', [Validators.required, Validators.minLength(2), Validators.maxLength(45)]],
      description: ['', [Validators.required, Validators.minLength(2)]],
      image: [''],
    });
  }

  // Fill Form Input
  updateFormValues() {
    this.uploadForm.patchValue({    // Insert Our category Data Into Form Fields
      name: this.categoryData.name,
      description: this.categoryData.description,
      image: this.categoryData.image
    });
  }

  // Select Image Information
  updateName(imageInput: any) {
    const file: File = imageInput.files[0];
    this.uploadButtonValue = 'Upload';
    this.imageName = file.name;
    this.fileSelected = true;
  }


  // Upload The Image And Get The Image URL
  processFile(imageInput: any) {
    this.imagePathReady = false;
    this.fileSelected = false;
    this.uploadButtonValue = 'Uploading...';
    console.log('Processing File');
    const file: File = imageInput.files[0];
    const reader = new FileReader();

    reader.addEventListener('load', (event: any) => {
      this.selectedFile = new ImageSnippet(event.target.result, file);
      this.categoryService.uploadImage(this.selectedFile.file).subscribe(
        (res) => {
          this.imageUrl = res;
          this.uploadButtonValue = 'Uploaded';
          this.imagePathReady = true;
          this.submitButtonValue = 'Update Category';
        },
        (err) => {
          console.log(err);
        });
    });
    reader.readAsDataURL(file);
  }


  // Submit Form
  mySubmit() {
    this.isSubmitted = true;
    if (!this.uploadForm.valid) {
      this.toaster.error('Error : All Fields Are Required');
      return false;
    } else {
      // Fetch All Form Data On Json Type
      const formObj = this.uploadForm.getRawValue();
      formObj.id = this.categoryId;
      if (this.imageUrl) {
        formObj.image = this.imageUrl;
      } else {
        formObj.image = this.categoryData.imageURL;
      }
      this.categoryService.updateCategory(formObj).subscribe(
        data => {
          console.log('The post request was successfully done', data);
          this.toaster.success('Category Uploaded Successfully');
        },
        error => {
          this.toaster.error('Error : Please Try Again');
          console.log('Error fetching data', error);
        },
        () => {
          this.router.navigate(['../../'], {relativeTo: this.activatedRoute});
        }
      );
    }
  }


}
